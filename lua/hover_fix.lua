-- lua/hover_fix.lua
--
-- Sanitize LSP hover text before it is rendered.
--
-- Two families of server junk are fixed here:
--   * C# servers (Roslyn / OmniSharp / csharp-ls) send CRLF line endings and
--     HTML entities like `&nbsp;` inside markdown -> `^M` at the end of every
--     line and literal `&nbsp;` in the float.
--   * Roslyn converts XML doc comments to markdown and backslash-escapes prose
--     punctuation (`.`, `_`, `-`, `(`, `)`, ...) the way CommonMark requires.
--     Neovim never resolves those escapes, so `DbContext\.SaveChanges\(\)`
--     shows up verbatim -> escapes are resolved here, in prose only.
--
-- Neovim >= 0.11. No deprecated API:
--   * vim.lsp.handlers / vim.lsp.with  -> gone (0.11); they no longer affect
--                                         vim.lsp.buf.hover() anyway
--   * vim.lsp.util.stylize_markdown    -> deprecated (0.14)
--   * nvim_buf_add_highlight           -> vim.hl.range

local M = {}

-- Most specific first; `&amp;` last so "&amp;nbsp;" does not decode twice.
local ENTITIES = {
    { "&nbsp;", " " },
    { "&#160;", " " },
    { "&ensp;", " " },
    { "&emsp;", " " },
    { "&lt;", "<" },
    { "&gt;", ">" },
    { "&quot;", '"' },
    { "&#39;", "'" },
    { "&apos;", "'" },
    { "&amp;", "&" },
}

-- ASCII punctuation that a backslash may escape in CommonMark.
local ESCAPABLE = {}
for ch in ("!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"):gmatch(".") do
    ESCAPABLE[ch] = true
end

--- Resolve backslash escapes on one line of markdown prose.
--- Inline code spans (`like this`) are literal, so their backslashes are kept;
--- a code span never spans a newline, so this state resets for every line.
---@param line string
---@return string
local function unescape_line(line)
    if not line:find("\\", 1, true) then
        return line
    end
    local out, i, code = {}, 1, 0
    local n = #line
    while i <= n do
        local ch = line:sub(i, i)
        if ch == "\\" and code == 0 then
            local escaped = line:sub(i + 1, i + 1)
            if ESCAPABLE[escaped] then
                out[#out + 1] = escaped -- drop the backslash, keep the character
                i = i + 2
            else
                out[#out + 1] = ch -- not an escape (C:\Users\x.exe) -> keep both
                i = i + 1
            end
        elseif ch == "`" then
            local run = line:sub(i):match("^`+")
            local len = #run
            if code == 0 then
                code = len
            elseif code == len then
                code = 0
            end
            out[#out + 1] = run
            i = i + len
        else
            out[#out + 1] = ch
            i = i + 1
        end
    end
    return table.concat(out)
end

--- Resolve CommonMark backslash escapes in markdown prose, leaving fenced code
--- blocks (```csharp ... ```) verbatim, so a regex or Windows path inside a
--- code block keeps every backslash it has.
---@param text string
---@return string
local function unescape_markdown(text)
    local out, fence = {}, nil
    for line in (text .. "\n"):gmatch("([^\n]*)\n") do
        if fence then
            out[#out + 1] = line
            local trimmed = line:match("^%s*(.-)%s*$")
            if #trimmed >= #fence and not trimmed:find("[^" .. fence:sub(1, 1) .. "]") then
                fence = nil -- closing fence of the same character
            end
        else
            local opener = line:match("^%s*(`+)") or line:match("^%s*(~+)")
            if opener and #opener >= 3 then
                fence = opener
                out[#out + 1] = line
            else
                out[#out + 1] = unescape_line(line)
            end
        end
    end
    return table.concat(out, "\n")
end

--- Fix one string of server-provided markup.
---@param text string?
---@param mode "markdown"|"plaintext"|"code"? how it will be rendered:
---            markdown  = prose: entities and backslash escapes are decoded
---            plaintext = entities decoded, backslashes stay literal
---            code      = verbatim apart from line endings
---@return string?
function M.clean(text, mode)
    if type(text) ~= "string" or text == "" then
        return text
    end
    text = text:gsub("\r\n", "\n"):gsub("\r", "\n")
    if mode ~= "code" then
        for _, entity in ipairs(ENTITIES) do
            text = text:gsub(entity[1], entity[2])
        end
    end
    if mode == nil or mode == "markdown" then
        text = unescape_markdown(text)
    end
    return text
end

--- Clean an `lsp.Hover.contents` value, whatever shape it has: MarkupContent,
--- MarkedString, MarkedString-pair, or arrays of either. MarkedString pairs
--- (`{ language = "csharp", value = <code> }`) are code, so only their line
--- endings are normalized.
---@param contents table|string
---@return table|string
local function sanitize_contents(contents)
    if type(contents) == "string" then
        return M.clean(contents, "markdown")
    end
    if type(contents) ~= "table" then
        return contents
    end
    local mode
    if contents.kind == "plaintext" then
        mode = "plaintext"
    elseif contents.kind then
        mode = "markdown"
    elseif contents.language then
        mode = "code" -- MarkedString pair: the value is already a code block
    else
        local out = {}
        for i, item in ipairs(contents) do
            out[i] = sanitize_contents(item)
        end
        return out
    end
    return vim.tbl_extend("force", {}, contents, { value = M.clean(contents.value, mode) })
end

local ns = vim.api.nvim_create_namespace("hover_fix.reference")

--- Keep the symbol under the cursor highlighted while the float is open
--- (what the built-in hover does with the `range` field of the response).
local function highlight_range(bufnr, range, encoding)
    if not range then
        return
    end
    local function to_byte(pos)
        local line = vim.api.nvim_buf_get_lines(bufnr, pos.line, pos.line + 1, false)[1] or ""
        local byte = vim.str_byteindex(line, encoding, pos.character)
        return { pos.line, math.max(0, math.min(byte, #line)) }
    end
    vim.hl.range(bufnr, ns, "LspReferenceTarget", to_byte(range.start), to_byte(range["end"]), {
        priority = vim.hl.priorities.user,
    })
end

--- Options applied to every hover float. Override per call via `M.hover{}`,
--- or globally via `M.setup{}`.
--- `border` is set here on purpose: it beats the global 'winborder' option.
---@type vim.lsp.util.open_floating_preview.Opts
local DEFAULTS = {
    border = "rounded",
    -- pressing the hover key again jumps into the float, like the built-in
    focus_id = "textDocument/hover",
}

--- Change the defaults used by every `M.hover()` call.
---@param opts vim.lsp.util.open_floating_preview.Opts? border/title/wrap/...
function M.setup(opts)
    DEFAULTS = vim.tbl_extend("force", DEFAULTS, opts or {})
end

--- Drop-in replacement for `vim.lsp.buf.hover()`.
---@param config vim.lsp.util.open_floating_preview.Opts? border/wrap/title/...
function M.hover(config)
    -- caller's config wins over DEFAULTS
    config = vim.tbl_extend("force", DEFAULTS, config or {})

    local bufnr = vim.api.nvim_get_current_buf()
    local win = vim.api.nvim_get_current_win()

    vim.lsp.buf_request_all(bufnr, "textDocument/hover", function(client)
        -- params are built per client: position encoding differs per server
        return vim.lsp.util.make_position_params(win, client.offset_encoding)
    end, function(results, ctx)
        if not ctx.bufnr or not vim.api.nvim_buf_is_valid(ctx.bufnr) then
            return
        end
        if vim.api.nvim_get_current_buf() ~= ctx.bufnr then
            return -- slow server: the user moved on
        end

        local valid = {} ---@type { client: vim.lsp.Client, result: table, lines: string[], plain: boolean }[]
        local empty_response = false

        for client_id, resp in pairs(results) do
            if resp.err then
                vim.notify(("hover failed: %s (%d)"):format(resp.err.message, resp.err.code), vim.log.levels.ERROR)
            elseif resp.result and resp.result.contents then
                -- >>> the whole point: clean the text *before* it becomes buffer lines
                local contents = sanitize_contents(resp.result.contents)
                local plain = type(contents) == "table" and contents.kind == "plaintext"
                local lines = plain and vim.split(contents.value or "", "\n", { trimempty = true })
                    or vim.lsp.util.convert_input_to_markdown_lines(contents)
                if vim.tbl_isempty(lines) then
                    empty_response = true
                else
                    valid[#valid + 1] = {
                        client = vim.lsp.get_client_by_id(client_id),
                        result = resp.result,
                        lines = lines,
                        plain = plain,
                    }
                end
            end
        end

        if #valid == 0 then
            if config.silent ~= true then
                vim.notify(empty_response and "Empty hover response" or "No information available", vim.log.levels.INFO)
            end
            return
        end

        local lines = {} ---@type string[]
        local format = "markdown"
        for _, entry in ipairs(valid) do
            if #valid > 1 then
                lines[#lines + 1] = "# " .. (entry.client and entry.client.name or "client")
            end
            if entry.plain and #valid == 1 then
                format = "plaintext"
                lines = entry.lines
            elseif entry.plain then
                lines[#lines + 1] = "```"
                vim.list_extend(lines, entry.lines)
                lines[#lines + 1] = "```"
            else
                vim.list_extend(lines, entry.lines)
            end
            if entry.client then
                highlight_range(ctx.bufnr, entry.result.range, entry.client.offset_encoding)
            end
            lines[#lines + 1] = "---"
        end
        if #lines > 0 then
            lines[#lines] = nil -- drop trailing separator
        end

        local _, winid = vim.lsp.util.open_floating_preview(lines, format, config)
        vim.api.nvim_create_autocmd("WinClosed", {
            pattern = tostring(winid),
            once = true,
            callback = function()
                vim.api.nvim_buf_clear_namespace(ctx.bufnr, ns, 0, -1)
                return true
            end,
        })
    end)
end

return M

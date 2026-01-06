return {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                return
            end
        end

        -- lua ls returns two definitions on vim.lsp.buf.definition()
        -- in order to fix this, use the following code.
        -- when the ticket https://github.com/LuaLS/lua-language-server/issues/2451
        -- will be resolved, you can delete the code.
        local locations_to_items = vim.lsp.util.locations_to_items
        vim.lsp.util.locations_to_items = function(locations, offset_encoding)
            local lines = {}
            local loc_i = 1
            for _, loc in ipairs(vim.deepcopy(locations)) do
                local uri = loc.uri or loc.targetUri
                local range = loc.range or loc.targetSelectionRange
                if lines[uri .. range.start.line] then -- already have a location on this line
                    table.remove(locations, loc_i) -- remove from the original list
                else
                    loc_i = loc_i + 1
                end
                lines[uri .. range.start.line] = true
            end

            return locations_to_items(locations, offset_encoding)
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
            runtime = {
                -- Tell the language server which version of Lua you're using
                -- (most likely LuaJIT in the case of Neovim)
                version = "LuaJIT",
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME .. "lua",
                    "~/.local/share/nvim/luv/lib",
                },
            },
        })
    end,
    settings = {
        Lua = {
            diagnostics = {
                disable = { "incomplete-signature-doc", "missing-fields" },
                globals = { "vim", "MiniMap" },
            },
        },
    },
}

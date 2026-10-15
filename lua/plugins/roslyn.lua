local opts = {
    broad_search = false,
    filewatching = "roslyn",
}

local cs_interpise_projects = string.find(vim.uv.cwd(), "panelapps")

if cs_interpise_projects ~= nil then
    opts.broad_search = true
    opts.filewatching = "off"
end

return {
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        enabled = true,
        config = function()
            require("roslyn").setup(opts)

            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if not client then
                        return
                    end

                    -- Intercept hover data specifically for C# language servers (OmniSharp or Roslyn)
                    if client.name == "omnisharp" or client.name == "roslyn" then
                        vim.keymap.set("n", "K", function()
                            require("hover_fix").hover()
                        end, { buffer = args.buf, desc = "hover (sanitized)" })
                    end
                end,
            })

            -- Temp solution because roslyn is not always updated automatically
            -- taken from https://github.com/seblyng/roslyn.nvim/wiki#diagnostic-refresh
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                pattern = "*.cs",
                callback = function()
                    local clients = vim.lsp.get_clients({ name = "roslyn" })
                    if not clients or #clients == 0 then
                        return
                    end

                    local client = clients[1]
                    local buffers = vim.lsp.get_client_by_id(client.id)

                    vim.lsp.codelens.enable(true)

                    for _, buf in ipairs(buffers) do
                        local params = { textDocument = vim.lsp.util.make_text_document_params(buf) }
                        client:request("textDocument/diagnostic", params, nil, buf)
                    end
                end,
            })

            vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
                pattern = "*__virtual.html",
                callback = function(args)
                    vim.opt_local.swapfile = false
                    vim.opt_local.bufhidden = "hide"
                    vim.opt_local.buftype = "nofile"
                    vim.opt_local.undofile = false
                    vim.opt_local.matchpairs = ""
                end,
            })

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local capabilities = require("blink.cmp").get_lsp_capabilities()

            local root_dir = vim.lsp.config["roslyn"].root_dir
            vim.lsp.config("roslyn", {
                on_attach = function(client, bufnr)
                    local filetype = vim.bo[bufnr].filetype
                    local buf_name = vim.api.nvim_buf_get_name(bufnr)

                    -- Check if it's a razor file, cshtml file, or virtual roslyn buffer
                    if filetype == "razor" or filetype == "cshtml" or buf_name:match("__virtual%.html$") then
                        -- Explicitly force hints off for Razor buffers to prevent UI lag
                        vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
                    else
                        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    end
                end,
                capabilities = capabilities,
                settings = {
                    ["csharp|background_analysis"] = {
                        dotnet_analyzer_diagnostics_scope = "openFiles",
                    },
                    ["csharp|inlay_hints"] = {
                        csharp_enable_inlay_hints_for_implicit_object_creation = true,
                        csharp_enable_inlay_hints_for_implicit_variable_types = true,
                        csharp_enable_inlay_hints_for_types = true,
                    },
                    ["csharp|code_lens"] = {
                        dotnet_enable_references_code_lens = true,
                    },
                    ["csharp|symbol_search"] = {
                        dotnet_search_reference_assemblies = true,
                    },
                    ["csharp|completion"] = {
                        dotnet_show_completion_items_from_unimported_namespaces = true,
                    },
                },
                -- disable duplicate client spawn
                root_dir = function(bufnr, on_dir)
                    local buf_name = vim.api.nvim_buf_get_name(bufnr)
                    if buf_name:match("^%w+://") then
                        return
                    end

                    root_dir(bufnr, on_dir)
                end,
            })
        end,
    },
}

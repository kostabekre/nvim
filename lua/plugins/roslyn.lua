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

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- local capabilities = require("blink.cmp").get_lsp_capabilities()

            vim.lsp.config("roslyn", {
                on_attach = function()
                    vim.lsp.inlay_hint.enable()
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
            })
        end,
    },
}

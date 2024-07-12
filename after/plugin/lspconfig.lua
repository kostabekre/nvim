local ok_result, lspconfig = pcall(require, "lspconfig")
if not ok_result then
    print("lspconfig config is not founded")
    return
end

local ok_result, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not ok_result then
    print("cmp_nvim_lsp config is not founded")
    return
end

local opts = { noremap = true, silent = true }

local on_attach = function (client, bufnr)
    opts.buffer = bufnr

    opts.desc = "Show LSP References"
    keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to Declaration"
    keymap("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Go to LSP definitions"
    keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Go to LSP implementations"
    keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)


    opts.desc = "Go to LSP type definitions"
    keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    keymap({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer Diagnostics"
    keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show Line Diagnostics"
    keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to Previous Diagnostic"
    keymap("n", "<leader>[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to Next Diagnostic"
    keymap("n", "<leader>]d", vim.diagnostic.goto_next, opts)

    opts.desc = "Show Documentation"
    keymap("n", "<leader>K", vim.lsp.buf.hover, opts)

    opts.desc = "LSP Restart"
    keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig["html"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "Lua 5.1"
            },
            diagnostics = {
                globals = {
                    "vim",
                }
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                }
            }
        }
    }
})

local pid = vim.fn.getpid()

local omniSharpPath = ""
if vim.fn.has('unix') == 1 then
    omniSharpPath = vim.fn.stdpath("data") .. "/mason/packages/omnisharp-mono/omnisharp/Omnisharp.dll"
else
    omniSharpPath = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/omnisharp.cmd"
end

lspconfig["omnisharp"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { omniSharpPath, "--languageserver" , "--hostPID", tostring(pid) },
})

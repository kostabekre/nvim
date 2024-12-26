local lsp_group = vim.api.nvim_create_augroup("DefaultLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function()
        --       TODO: what is it?
        --       require("config.lspconfig.handlers").handlers()

        keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show LSP References" })

        keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

        keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to LSP definitions" })

        keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", { desc = "Go to LSP implementations" })

        keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", { desc = "Go to LSP type definitions" })

        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })

        keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

        keymap("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Show buffer Diagnostics" })

        keymap("n", "<leader>dK", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

        keymap("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })

        keymap("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })

        keymap("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show Documentation" })

        keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
        keymap("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle inlay hints" })
    end,
})

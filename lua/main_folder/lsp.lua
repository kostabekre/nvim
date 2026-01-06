vim.lsp.enable("gdscript")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        vim.diagnostic.config({
            float = {
                source = true,
                border = "rounded",
            },
        })

        vim.keymap.set("n", "<leader>gr", function()
            require("telescope.builtin").lsp_references({ fname_width = 40, include_declaration = false })
        end, { desc = "Show LSP References" })

        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

        -- temporarly added here, because it's overriding obsidian mapping.
        if client.name ~= "render-markdown" or client.name ~= "ltex_plus" then
            vim.keymap.set("n", "<leader>gd", function()
                require("telescope.builtin").lsp_definitions({})
            end, { desc = "Go to LSP definitions" })
        end

        vim.keymap.set(
            "n",
            "<leader>gi",
            "<cmd>Telescope lsp_implementations<CR>",
            { desc = "Go to LSP implementations" }
        )

        vim.keymap.set(
            "n",
            "<leader>gt",
            "<cmd>Telescope lsp_type_definitions<CR>",
            { desc = "Go to LSP type definitions" }
        )

        vim.keymap.set("n", "<leader>fo", function()
            require("telescope.builtin").lsp_document_symbols({ symbols = { "function", "method" } })
        end, { desc = "Go to LSP functions" })

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

        vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Show buffer Diagnostics" })

        vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

        vim.keymap.set("n", "<leader>dk", function()
            vim.diagnostic.jump({ count = -1, float = true })
        end, { desc = "Go to Previous Diagnostic" })

        vim.keymap.set("n", "<leader>dj", function()
            vim.diagnostic.jump({ count = 1, float = true })
        end, { desc = "Go to Next Diagnostic" })

        vim.keymap.set("n", "K", function()
            vim.lsp.buf.hover({
                border = "rounded",
            })
        end, { desc = "Show Documentation", buffer = true })

        vim.keymap.set("n", "<leader>K", function()
            vim.lsp.buf.signature_help({
                border = "rounded",
            })
        end, { desc = "Show Documentation about the symbol under the cursor", buffer = true })

        vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
        vim.keymap.set("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, { desc = "Toggle inlay hints" })
    end,
})

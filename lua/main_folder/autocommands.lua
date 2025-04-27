local lsp_group = vim.api.nvim_create_augroup("DefaultLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = lsp_group,
	callback = function()
		--       TODO: what is it?
		--       require("config.lspconfig.handlers").handlers()

		vim.keymap.set(
			"n",
			"<leader>gr",
			--"<cmd>Telescope lsp_references({ include_declaration = false, fname_width = 20 })<CR>",
			function()
				require("telescope.builtin").lsp_references({ fname_width = 40, include_declaration = false })
			end,
			{ desc = "Show LSP References" }
		)

		vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

		vim.keymap.set("n", "<leader>gd", function()
			require("telescope.builtin").lsp_definitions({})
		end, { desc = "Go to LSP definitions" })

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
			require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
		end, { desc = "Go to LSP functions" })

		vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })

		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

		vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Show buffer Diagnostics" })

		vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

		vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { desc = "Go to Previous Diagnostic" })

		vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { desc = "Go to Next Diagnostic" })

		vim.keymap.set("n", "<leader>K", vim.lsp.buf.hover, { desc = "Show Documentation" })

		vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
		vim.keymap.set("n", "<leader>th", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, { desc = "Toggle inlay hints" })
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

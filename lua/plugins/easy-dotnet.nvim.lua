return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		cond = function(_)
			local util = require("lspconfig.util")
			local pattern_func = util.root_pattern("*.sln", ".csproj")

			local root = pattern_func(vim.uv.cwd())
			if not root then
				return false
			end

			return true
		end,
		config = function()
			require("easy-dotnet").setup({
				auto_bootstrap_namespace = {
					--block_scoped, file_scoped
					type = "file_scoped",
					enabled = true,
					use_clipboard_json = {
						behavior = "prompt", --'auto' | 'prompt' | 'never',
						register = "+", -- which register to check
					},
				},
			})
			vim.keymap.set("n", "<leader>Nt", ":Dotnet testrunner refresh<CR>")
			vim.keymap.set("n", "<leader>Nrt", ":Dotnet testrunner<CR>")
		end,
	},
}

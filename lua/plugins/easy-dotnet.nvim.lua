return {
	{
		"GustavEikaas/easy-dotnet.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		dir = "~/source/neovim/plugins/easy-dotnet.nvim",
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
		end,
	},
}

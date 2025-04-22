return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = true,
		-- config = function ()
		--     vim.g.gruvbox_material_enable_italic = true
		--     ColorMyEditor('gruvbox-material')
		-- end
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			ColorMyEditor("tokyonight-night")
		end,
	},
}

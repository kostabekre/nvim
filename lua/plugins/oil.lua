return {
	"stevearc/oil.nvim",
	config = function()
		require("oil").setup({})

		vim.keymap.set("n", "<c-w>e", "<CMD>Oil<CR>", { desc = "Open parent directory" })
	end,
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
	-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
	lazy = false,
}

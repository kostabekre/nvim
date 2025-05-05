return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup()
			vim.keymap.set("n", "<leader>an", "<cmd>Gitsigns blame<CR>")
			vim.keymap.set("n", "<leader>al", "<cmd>Gitsigns blame_line<CR>")
		end,
		event = "BufReadPre",
	},
}

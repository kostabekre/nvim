return {
	{
		"mbbill/undotree", -- history of undos
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Show undo history" })
		end,
		keys = { "<leader>u" },
	},
}

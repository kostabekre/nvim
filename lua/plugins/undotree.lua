--  Saves the history of changes of files.
return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Show undo history" })
		end,
		keys = { "<leader>u" },
	},
}

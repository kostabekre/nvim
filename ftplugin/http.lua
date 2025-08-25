-- config in lazy is not called, so make keybindings here
require("telescope").load_extension("rest")

-- local wk = require("which-key")
-- wk.add({
-- 	{ "<CR>", "<CMD>Rest run<CR>", desc = "Run Rest", mode = "n", group = "Rest" },
-- 	{ "<leader>ro", "<CMD>Rest logs<CR>", desc = "Show Rest Logs", mode = "n", group = "Rest" },
-- 	{ "<leader>ro", "<CMD>Rest logs<CR>", desc = "Rest Run Last", mode = "n", group = "Rest" },
-- 	{ "<leader>rc", "<CMD>Rest cookies<CR>", desc = "Show Rest Cookies", mode = "n", group = "Rest" },
-- 	{
-- 		"<leader>re",
-- 		function()
-- 			require("telescope").extensions.rest.select_env()
-- 		end,
-- 		desc = "Rest Show environment",
-- 		mode = "n",
-- 		group = "Rest",
-- 	},
-- })

vim.keymap.set("n", "<CR>", "<CMD>Rest run<CR>", { desc = "Run Rest" })
vim.keymap.set("n", "<leader>ro", "<CMD>Rest logs<CR>", { desc = "Show Rest Logs" })
vim.keymap.set("n", "<leader>ra", "<CMD>Rest last<CR>", { desc = "Rest Run Last" })
vim.keymap.set("n", "<leader>rc", "<CMD>Rest cookies<CR>", { desc = "Show Rest Cookies" })
vim.keymap.set("n", "<leader>re", function()
	require("telescope").extensions.rest.select_env()
end, { desc = "Show environment" })

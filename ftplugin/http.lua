require("telescope").load_extension("rest")

vim.keymap.set("n", "<CR>", "<CMD>Rest run<CR>", { desc = "Run Rest" })
vim.keymap.set("n", "<leader>ro", "<CMD>Rest open<CR>", { desc = "Rest Result Panel" })
vim.keymap.set("n", "<leader>ra", "<CMD>Rest last<CR>", { desc = "Rest Run Last" })
vim.keymap.set("n", "<leader>rc", "<CMD>Rest cookies<CR>", { desc = "Show Rest Cookies" })
vim.keymap.set("n", "<leader>re", function()
    require("telescope").extensions.rest.select_env()
end, { desc = "Show environment" })

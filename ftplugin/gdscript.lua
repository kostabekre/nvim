vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.softtabstop = 2

vim.keymap.set("n", "<F6>", "<cmd>GodotRunLast<CR>")
vim.keymap.set("n", "<F7>", "<cmd>GodotRun<CR>")
vim.keymap.set("n", "<F8>", "<cmd>GodotRunCurrent<CR>")
vim.keymap.set("n", "<F9>", "<cmd>GodotRunFZF<CR>")

vim.lsp.enable("gdscript")

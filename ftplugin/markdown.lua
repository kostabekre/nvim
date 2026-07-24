vim.opt.foldlevel = 1
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = ""
vim.opt.foldlevel = 99

vim.keymap.set("n", "<leader>oc", function()
    vim.api.nvim_cmd({ cmd = "ObsidianBridgeOpenCurrentActiveFile" }, {})
end, { desc = "Open current obsidian note in neovim" })

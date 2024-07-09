vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- insert n spaces for a tab character
vim.opt.softtabstop = 4 -- insert n spaces on Tab key or remove n spaces on Backspace key
vim.opt.shiftwidth = 4 -- insert n columns for each indentation
vim.opt.expandtab = true -- convert tabs to spaces

vim.opt.smartindent = true

vim.opt.wrap = false -- display a line as multiple/one long line

vim.opt.swapfile = false -- creates a swapfile
vim.opt.backup = false -- creates a backup
vim.opt.undofile = true -- creates an undo file
if vim.fn.has('unix') == 1 then
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
else
    vim.opt.undodir = os.getenv("HOMEPATH") .. "/.vim/undodir"
end

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.mouse = "a"

vim.opt.updatetime = 50


local options = {
    nu = true,
    relativenumber = true,
    tabstop = 4, -- insert n spaces for a tab character
    expandtab = true, -- convert tabs to spaces
    softtabstop = 4, -- insert n spaces on Tab key or remove n spaces on Backspace key
    shiftwidth = 4, -- insert n columns for each indentation
    smartindent = true,
    wrap = false, -- display a line as multiple/one long line
    swapfile = false, -- creates a swapfile
    backup = false, -- creates a backup
    undofile = true, -- creates an undo file
    hlsearch = false,
    incsearch = true,
    termguicolors = true,
    scrolloff = 8,
    signcolumn = "yes",
    mouse = "a",
    updatetime = 50,
}

for key, value in pairs(options) do
    vim.opt[key] = value
end

---@type (string?)
local homepath

if vim.fn.has('unix') == 1 then
    homepath = os.getenv("HOME")
else
    homepath = os.getenv("HOMEPATH")
end
vim.opt.undodir = homepath .. "/.vim/undodir"

vim.opt.isfname:append("@-@")

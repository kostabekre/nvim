local options = {
    nu = true,
    relativenumber = true,
    tabstop = 4, -- insert n spaces for a tab character
    softtabstop = 4, -- insert n spaces on Tab key or remove n spaces on Backspace key
    shiftwidth = 4, -- insert n columns for each indentation
    expandtab = true, -- convert tabs to spaces
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
    updatetime = 50
}

for key, value in pairs(options) do 
    vim.opt[key] = value
end

if vim.fn.has('unix') == 1 then
    vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
else
    vim.opt.undodir = os.getenv("HOMEPATH") .. "/.vim/undodir"
end

vim.opt.isfname:append("@-@")


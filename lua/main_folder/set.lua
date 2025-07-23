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
	updatetime = 50,
	foldmethod = "expr",
	-- foldexpr = "v:lua.vim.treesitter.foldexpr()",
	-- foldtext = "",
	-- foldlevel = 99,
}

for key, value in pairs(options) do
	vim.opt[key] = value
end

vim.cmd("language en_US")

-- https://github.com/NvChad/NvChad/issues/1907
vim.hl.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"

vim.opt.isfname:append("@-@")

function ColorMyEditor(color, transparent)
	color = color or "default"
	local status_ok, _ = pcall(vim.cmd, "colorscheme " .. color)
	if not status_ok then
		print("color scheme " .. color .. " is not found!")
		return
	end

	if transparent then
		vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
	end
end

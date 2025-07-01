vim.g.mapleader = " " -- leader key

-- Or use \c to ignorecase in the end of the search.
-- \C uses sensitivity search
vim.keymap.set("n", "<F9>", "<cmd>set ignorecase! ignorecase?<CR>")

vim.keymap.set("i", "jh", "<Esc>")
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "H", "<C-o>")
vim.keymap.set("n", "L", "<C-i>")

-- paste but do not copy
vim.keymap.set("x", "<leader>p", [["_dP]])
-- copy to environment
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
-- delete but do not copy
vim.keymap.set({ "n", "v" }, "<leader>dd", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set({ "n", "i" }, "<D-space>", "<Nop>", { noremap = true, silent = true })

-- Buffers
vim.keymap.set("n", "<Leader>bd", "<cmd>%bd|e#|bd#<CR>", { desc = "Remove all buffers but current" })

-- quickfix
vim.keymap.set("n", "<Leader>qo", "<cmd>co<CR>", { desc = "Open quickfix" })
vim.keymap.set("n", "<Leader>qj", "<cmd>cp<CR>zz", { desc = "Previous item in quickfix" })
vim.keymap.set("n", "<Leader>qk", "<cmd>cn<CR>zz", { desc = "Next item in quickfix" })
vim.keymap.set("n", "<Leader>qp", "<cmd>colder<CR>", { desc = "Previous list of quickfix" })
vim.keymap.set("n", "<Leader>qn", "<cmd>cnewer<CR>", { desc = "Next list of quickfix" })

-- Case
vim.keymap.set("i", "<C-f>", "<esc>gUiw`]a", { desc = "Change the text under the cursor to upper case" })

-- Config file
if vim.fn.has("unix") == 1 then
	vim.keymap.set("n", "<leader>vc", "<cmd>e ~/.config/nvim/<CR>")
else
	vim.keymap.set("n", "<leader>vc", "<cmd>e ~/AppData/Local/nvim/<CR>")
end

vim.keymap.set("n", "<leader><leader>x", function()
	vim.cmd("so")
end)

if vim.fn.has("unix") == 1 then
	vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
end
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)

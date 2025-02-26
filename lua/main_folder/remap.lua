vim.g.mapleader = " " -- leader key

keymap = vim.keymap.set

keymap("n", "<C-w>e", vim.cmd.Ex) -- explorer

-- Or use \c to ignorecase in the end of the search. 
-- \C uses sensitivity search
keymap("n", "<F9>", "<cmd>set ignorecase! ignorecase?<CR>")

keymap("i", "jh", "<Esc>")
keymap("i", "<C-c>", "<Esc>")

keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

keymap("n", "J", "mzJ`z")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "H", "<C-o>")
keymap("n", "L", "<C-i>")

-- paste but do not copy
keymap("x", "<leader>p", [["_dP]])
-- copy to environment
keymap({"n", "v"}, "<leader>y", [["+y]])
keymap("n", "<leader>Y", [["+Y]])
-- delete but do not copy
keymap({"n", "v"}, "<leader>dd", [["_d]])

keymap("n", "Q", "<nop>")

-- keymap("n", "<C-k>", "<cmd>cnext<CR>zz")
-- keymap("n", "<C-j>", "<cmd>cprev<CR>zz")
keymap("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap("n", "<leader>j", "<cmd>lprev<CR>zz")

keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
keymap({"n", "i"}, "<D-space>", "<Nop>", {noremap = true, silent = true })

-- Config file
if vim.fn.has('unix') == 1 then
    keymap("n", "<leader>vc", "<cmd>e ~/.config/nvim/<CR>");
else
    keymap("n", "<leader>vc", "<cmd>e ~/AppData/Local/nvim/<CR>");
end

keymap("n", "<leader><leader>x", function()
    vim.cmd("so")
end)

if vim.fn.has('unix') == 1 then
    keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
end
keymap("n", "<leader>lf", vim.lsp.buf.format)

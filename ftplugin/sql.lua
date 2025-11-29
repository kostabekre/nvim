vim.keymap.set(
	"n",
	"<leader><CR>",
	":normal vip<CR><PLUG>(DBUI_ExecuteQuery)",
	{ buffer = true, desc = "run query under cursor" }
)

vim.keymap.set("x", "<leader><CR>", "<PLUG>(DBUI_ExecuteQuery)", { buffer = true, desc = "run selected query" })

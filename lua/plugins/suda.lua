return {
	"lambdalisue/suda.vim",
	cond = function(_)
		return vim.fn.has("unix") == 1
	end,
	cmd = { "SudaRead", "SudaWrite" },
}

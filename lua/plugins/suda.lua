if vim.fn.has("unix") == 0 then
	return {}
end

return {
	"lambdalisue/suda.vim",
	cmd = { "SudaRead", "SudaWrite" },
}

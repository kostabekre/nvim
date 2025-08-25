-- HTTP client. As postman, but in your editor.

if vim.fn.has("win32") == 1 then
	return {}
end

return {
	"rest-nvim/rest.nvim",
	enabled = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
		end,
	},
}

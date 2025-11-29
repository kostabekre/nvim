-- Send queries to your DB from the neovim.

return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1

		---@field label - label of the entry you selected.
		---Example: "New Query", "List", "Indexes"
		---@field table - table name if buffer was created from table helper,
		---or empty string
		---@field schema - schema name if buffer was created from table
		--- helper, or empty string
		---@field filetype - filetype that will be used for the buffer
		vim.g.Db_ui_buffer_name_generator = function(opts)
			if vim.fn.empty(opts.table) then
				return "myquery-" .. vim.fn.localtime() .. "." .. opts.filetype
			end

			return "myquery-fortable-" .. opts.table .. "-" .. localtime() .. "." .. opts.filetype
		end
	end,
}

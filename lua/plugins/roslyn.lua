local cmp_nvim_lsp = require("cmp_nvim_lsp")
local default_capabilities = cmp_nvim_lsp.default_capabilities()
local uv = vim.uv

local cwd = uv.cwd()

local founded = string.find(cwd, "panelapps")
local opts = {
	broad_search = false,
	filewatching = "roslyn",
}

if founded ~= nil then
	opts.broad_search = true
	opts.filewatching = "off"
end

vim.print(cwd)
vim.print(vim.inspect(opts))

return {
	{
		"seblj/roslyn.nvim",
		ft = "cs",
		config = function()
			require("roslyn").setup({
				broad_search = opts.broad_search,
				filewatching = opts.filewatching,
				config = {
					capabilities = default_capabilities,
				},
			})

			-- Temp solution because roslyn is not always updated automatically
			-- taken from https://github.com/seblyng/roslyn.nvim/wiki#diagnostic-refresh
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				pattern = "*",
				callback = function()
					local clients = vim.lsp.get_clients({ name = "roslyn" })
					if not clients or #clients == 0 then
						return
					end

					local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
					for _, buf in ipairs(buffers) do
						vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
					end
				end,
			})
		end,
	},
}

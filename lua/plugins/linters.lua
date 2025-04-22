return {
	{
		"mfussenegger/nvim-lint",
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				gdscript = { "gdlint" },
				html = { "htmlhint" },
				javascript = { "standardjs" },
				-- lua = { 'luacheck' }
			}

			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
				group = lint_augroup,
				callback = function()
					lint.try_lint()
				end,
			})

			vim.keymap.set("n", "<leader>ll", function()
				lint.try_lint()
			end, { desc = "Trigger linting manually" })

			vim.keymap.set("n", "<leader>li", function()
				local linters = lint.get_running()
				if #linters == 0 then
					print("no linters running")
					return
				end
				print("󱉶 " .. table.concat(linters, ", "))
			end, { desc = "Show running linters" })
		end,
	},
}

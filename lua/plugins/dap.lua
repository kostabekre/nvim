return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",

			-- Required dependency for nvim-dap-ui
			"nvim-neotest/nvim-nio",

			-- Installs the debug adapters for you
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",

			-- Add your own debuggers here
			-- 'leoluz/nvim-dap-go',
		},
		keys = {
			"<F5>",
			"<F10>",
			"<F11>",
			"shift + <F11>",
			"<F12>",
			"<leader>b",
			"<leader>B",
			"<leader>lp",
			"<leader>dr",
			"<leader>dl",
			"<leader>dh",
			"<leader>dp",
			"<leader>df",
			"<leader>ds",
		},
		config = function()
			local status_ok, dap = pcall(require, "dap")
			if not status_ok then
				print("nvim-dap is not installed!")
				return
			end

			local status_ok_ui, dapui = pcall(require, "dapui")
			if not status_ok_ui then
				print("nvim-dap is not installed!")
				return
			end

			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end, { desc = "Continue debuging" })
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end)
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end)
			vim.keymap.set("n", "shift + <F11>", function()
				dap.step_out()
			end)
			vim.keymap.set("n", "<F12>", function()
				dapui.toggle()
			end)
			vim.keymap.set("n", "<Leader>b", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			vim.keymap.set("n", "<Leader>B", function()
				dap.set_breakpoint()
			end)
			vim.keymap.set("n", "<Leader>lp", function()
				dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end)
			vim.keymap.set("n", "<Leader>dr", function()
				dap.repl.open()
			end)
			vim.keymap.set("n", "<Leader>dl", function()
				dap.run_last()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
				require("dap.ui.widgets").hover()
			end)
			vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
				require("dap.ui.widgets").preview()
			end)
			vim.keymap.set("n", "<Leader>df", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end)
			vim.keymap.set("n", "<Leader>ds", function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.scopes)
			end)

			require("mason-nvim-dap").setup({
				automatic_installation = true,

				handlers = {},

				ensure_installed = {},
			})

			dapui.setup({
				-- Set icons to characters that are more likely to work in every terminal.
				--    Feel free to remove or use ones that you like more! :)
				--    Don't feel like these are good choices.
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close
		end,
	},
}

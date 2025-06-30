-- Show next keys you need to press to perform a custom binding.

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		config = function()
			local wk = require("which-key")
			-- Comment
			wk.add({
				{ "gcc", desc = "Comment current line" },
				{ "gc{count{motion}}", desc = "Comment given motion n times" },
				{ "gc{motion}", desc = "Comment given motion" },
			})

			-- Telescope
			-- wk.add({
			-- 	{ "<leader>ff", desc = "Find Files" },
			-- })
		end,
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps.",
			},
		},
	},
}

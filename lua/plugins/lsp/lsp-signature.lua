-- nvim has vim.lsp.buf.signature_help, but the following plugin
-- has features that improves experience:
-- - improvment argument hightlight. In the default version the argument is hightlighted too, but less obvious.
-- - window is shown automatically, which allows to see what arguments you are typing.
-- - shows multiple signatures
return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	opts = {},
	config = function()
		local lsp_signature = require("lsp_signature")

		lsp_signature.setup({
			bind = true,
			handler_opts = {
				border = "rounded",
			},
			floating_window = false,
			hint_inline = function()
				return "eol"
			end,
		})
	end,
}

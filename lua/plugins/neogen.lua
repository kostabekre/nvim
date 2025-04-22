return {
	{
		"danymat/neogen",
		cmd = {
			"Neogen",
		},
		config = function()
			require("neogen").setup({
				snippet_engine = "luasnip",
				languages = {
					cs = {
						template = {
							annotation_convention = "xmldoc",
						},
					},
				},
			})
		end,
	},
}

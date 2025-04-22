return {
	{
		"williamboman/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
		event = {
			"BufReadPre",
		},
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
}

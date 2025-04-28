return {
	{
		"williamboman/mason.nvim",
		opts = {
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/mason-registry",
			},
		},
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
		},
	},
}

return {
    {
        'williamboman/mason.nvim',
        opts = {
            registries = {
                "github:mason-org/mason-registry",
                "github:Crashdummyy/mason-registry"
            }
        },
        dependencies = {
            'williamboman/mason-lspconfig.nvim',
        }
    }
}
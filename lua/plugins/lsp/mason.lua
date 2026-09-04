return {
    "williamboman/mason-lspconfig.nvim",
    opts = {
        ensure_installed = {
            "lua_ls",
            "stylua",
            "ltex_plus",
        },
    },
    dependencies = {
        {
            "williamboman/mason.nvim",
            config = true,
            opts = {
                registries = {
                    "github:mason-org/mason-registry",
                    "github:Crashdummyy/mason-registry",
                },
            },
        },
        "neovim/nvim-lspconfig",
    },
}

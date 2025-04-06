local cmp_nvim_lsp = require('cmp_nvim_lsp')
local default_capabilities = cmp_nvim_lsp.default_capabilities()

return {
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            broad_search = true,
            config = {
                capabilities = default_capabilities
            }
        },
    }

}

-- HTTP client. As postman, but in your editor.
-- you need to install lua5.1. On fedora the binary is lua-5.1, to fix this create a symlink: `ln -s /usr/bin/lua-5.1 ~/.local/bin/lua5.1`

if vim.fn.has("win32") == 1 then
    return {}
end

return {
    {
        "vhyrro/luarocks.nvim",
        enabled = false,
        priority = 1000,
        opts = {
            rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
        },
    },
    {
        "rest-nvim/rest.nvim",
        enabled = false,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            opts = function(_, opts)
                opts.ensure_installed = opts.ensure_installed or {}
                table.insert(opts.ensure_installed, "http")
            end,
            config = function()
                -- Configure options via global variable as per the official rest.nvim documentation
                -- No explicit .setup() call is needed for version 3.x+
                vim.g.rest_nvim = {
                    -- Add any custom configuration here (see :h rest-nvim.config)
                }
            end,
        },
    },
}

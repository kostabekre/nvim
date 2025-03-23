return {
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = "catppuccin",
    },
    {
        'sainnhe/gruvbox-material',
        lazy = false,
        priority = 1000,
        -- config = function ()
        --     vim.g.gruvbox_material_enable_italic = true
        --     ColorMyEditor('gruvbox-material')
        -- end
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        config = function ()
            ColorMyEditor('tokyonight-night')
        end

    }
}

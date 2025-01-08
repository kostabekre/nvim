return {
    {
        'catppuccin/nvim',
        lazy = false,
        priority = 1000,
        name = "catppuccin",
        config = function()
            function ColorMyEditor(color, transparent)
                color = color or "default"
                local status_ok, _ = pcall(vim.cmd, "colorscheme " .. color)
                if not status_ok then
                    print("color scheme " .. color .. " is not found!")
                    return
                end

                if transparent then
                    vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
                    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
                end
            end

            ColorMyEditor("catppuccin-latte", false)
        end
    },
}

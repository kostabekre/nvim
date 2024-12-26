if vim.fn.has('unix') == 0 then
    return {
        {
            "seblj/roslyn.nvim",
            ft = "cs",
            opts = {
                -- your configuration comes here; leave empty for default settings
            }
        }
    }
else
    return {}
end

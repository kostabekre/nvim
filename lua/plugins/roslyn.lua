if vim.fn.has('unix') == 0 then
    return {
        {
            "seblj/roslyn.nvim",
            ft = "cs",
            event = { "BufReadPre", "BufNewFile" },
            opts = {
                filewatching = false,
                broad_search = true,
            },
        }
    }
else
    return {}
end

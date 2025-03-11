return {
    {
        "seblj/roslyn.nvim",
        ft = "cs",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            filewatching = "auto",
            broad_search = true,
        },
    }

}

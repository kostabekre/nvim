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

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "vimdoc", "markdown", "markdown_inline", "cs", "yaml", "bash" },
    callback = function()
        vim.treesitter.start()
    end,
})

return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
    },
}

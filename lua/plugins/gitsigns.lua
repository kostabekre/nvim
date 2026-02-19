return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
            vim.keymap.set("n", "<leader>ab", "<cmd>Gitsigns blame<CR>")
            vim.keymap.set("n", "<leader>al", "<cmd>Gitsigns blame_line<CR>")
            vim.keymap.set("n", "<leader>aj", "<cmd>Gitsigns next_hunk<CR>")
            vim.keymap.set("n", "<leader>ak", "<cmd>Gitsigns prev_hunk<CR>")
        end,
        event = "BufReadPre",
    },
}

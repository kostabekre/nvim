return {
    {
        'mbbill/undotree', -- history of undos
        config = function()
            keymap("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Show undo history" })
        end,
        keys = { "<leader>u" }
    }
}

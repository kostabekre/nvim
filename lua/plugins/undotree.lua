return {
    {
        'mbbill/undotree', -- history of undos
        config = function()
            keymap("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
        keys = { "<leader>u" }
    }
}

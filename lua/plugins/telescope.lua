return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim'
        },
        opts = {
            defaults = {
                file_ignore_patterns = { ".godot" }
            }
        },
        keys = { "<leader>ff", "<leader>fg", "<leader>gf", "<leader>fb", "<leader>fh", "gd", "gt", "gi", "gr" },
        config = function()
            local telescope_builtin = require('telescope.builtin')

            keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = "Find files" })
            keymap('n', '<leader>gf', telescope_builtin.git_files, { desc = "Find git files" })
            keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = "Find in files" })
            keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = "Find buffers" })
            keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = "Find help tags" })
        end
    }
}

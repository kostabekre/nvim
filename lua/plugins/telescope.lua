return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' 
            }
        },
        keys = { "<leader>ff", "<leader>fg", "<leader>gf", "<leader>fb", "<leader>fh", "gd", "gt", "gi", "gr" },
        config = function()
            local telescope = require('telescope')

            telescope.setup {
                defaults = {
                    extensions = {
                        fzf = {
                            fuzzy = true,
                            override_generic_sorter = true,
                            override_file_sorter = true,
                            case_mode = "smart_case"
                        }
                    },
                    file_ignore_patterns = { ".godot", ".git" },
                    preview = {
                        hide_on_startup = true
                    },
                    path_display = {
                        shorten = 2
                    },
                    mappings = {
                        n = {
                            ["<C-t>"] = require('telescope.actions.layout').toggle_preview,
                            ["<C-b>"] = require("telescope.actions").delete_buffer,
                            ["l"] = require('telescope.actions').cycle_history_next,
                            ["h"] = require('telescope.actions').cycle_history_prev,
                        },
                        i = {
                            ["<C-t>"] = require("telescope.actions.layout").toggle_preview,
                            ["<C-b>"] = require("telescope.actions").delete_buffer,
                            -- ["<C-j>"] = require "telescope.actions.layout".toggle_results_and_prompt,
                        },
                    }
                },
                pickers = {
                    buffers = {
                        sort_mru = true
                    }
                }
            }

            require('telescope').load_extension('fzf')

            local telescope_builtin = require('telescope.builtin')

            keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = "Find files" })
            keymap('n', '<leader>gf', telescope_builtin.git_files, { desc = "Find git files" })
            keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = "Find in files" })
            keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = "Find buffers" })
            keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = "Find help tags" })
            keymap('n', '<leader>fr', telescope_builtin.resume, { desc = "Resume Telescope Search" })
        end
    }
}

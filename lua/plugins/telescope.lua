return {
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
            },
            {
                "nvim-telescope/telescope-frecency.nvim",
                -- install the latest stable version
                version = "*",
            }
        },
        keys = {
            "<leader>ff",
            "<leader>fg",
            "<leader>gf",
            "<leader>fb",
            "<leader>fh",
            "<leader>fr",
            "gd",
            "gt",
            "gi",
            "gr",
            "<leader>D"
        },

        config = function()
            local telescope = require('telescope')

            telescope.setup {
                defaults = {
                    file_ignore_patterns = { ".godot", ".git" },
                    preview = {
                        hide_on_startup = true
                    },
                    path_display = {
                        shorten = 3
                    },
                    mappings = {
                        n = {
                            ["<C-i>"] = require('telescope.actions.layout').toggle_preview,
                            ["<C-s>"] = require("telescope.actions").select_horizontal,
                            ["<C-x>"] = require("telescope.actions").delete_buffer,
                            ["l"] = require('telescope.actions').cycle_history_next,
                            ["h"] = require('telescope.actions').cycle_history_prev,
                        },
                        i = {
                            ["<C-s>"] = require("telescope.actions").select_horizontal,
                            ["<C-i>"] = require("telescope.actions.layout").toggle_preview,
                            ["<C-x>"] = require("telescope.actions").delete_buffer,
                        },
                    }
                },
                pickers = {
                    buffers = {
                        sort_mru = true
                    }
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case"
                    }
                },
            }

            require('telescope').load_extension('fzf')
            require("telescope").load_extension('frecency')

            local telescope_builtin = require('telescope.builtin')

            keymap('n', '<leader>ff', telescope_builtin.find_files, { desc = "Find files" })
            keymap('n', '<leader>fp', "<CMD>Telescope frecency workspace=CWD path_display={'shorten'}<CR>", { desc = "Previous Files" })
            keymap('n', '<leader>gf', telescope_builtin.git_files, { desc = "Find git files" })
            keymap('n', '<leader>fg', telescope_builtin.live_grep, { desc = "Find in files" })
            keymap('n', '<leader>fb', telescope_builtin.buffers, { desc = "Find buffers" })
            keymap('n', '<leader>fh', telescope_builtin.help_tags, { desc = "Find help tags" })
            keymap('n', '<leader>fr', telescope_builtin.resume, { desc = "Resume Telescope Search" })
        end
    }
}

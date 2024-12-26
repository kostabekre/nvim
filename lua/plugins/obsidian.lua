return {
    {
        "epwalsh/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        lazy = true,
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        event = {
            -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
            -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
            -- refer to `:h file-pattern` for more examples
            "BufReadPre " .. vim.fn.expand "~" .. "/MEGAsync/POWER/*.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/MEGAsync/POWER/*.md",
            "BufReadPre " .. vim.fn.expand "~" .. "/MEGAsync/WorkVault/*.md",
            "BufNewFile " .. vim.fn.expand "~" .. "/MEGAsync/WorkVault/*.md",
        },
        dependencies = {
            -- Required.
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        opts = {
            workspaces = {
                {
                    name = "personal",
                    path = "~/MEGAsync/POWER",
                    overrides = {
                        notes_subdir = "Base",
                    },
                },
                {
                    name = "work",
                    path = "~/MEGAsync/WorkVault",
                    overrides = {
                        notes_subdir = "Base",
                    },
                },
            },
            mappigns = {
                ['gd'] = {
                    action = function()
                        return require("obsidian").util.gf_passthrough()
                    end,
                    opts = { noremap = false, expr = true, buffer = true }
                },
                -- Toggle check-boxes.
                ["<leader>ch"] = {
                    action = function()
                        return require("obsidian").util.toggle_checkbox()
                    end,
                    opts = { buffer = true },
                },
                -- Smart action depending on context, either follow link or toggle checkbox.
                ["<leader>ca"] = {
                    action = function()
                        return require("obsidian").util.smart_action()
                    end,
                    opts = { buffer = true, expr = true },
                }
            },
            attachments = {
                img_folder = "files",
            }
        },
        -- config = function()
        --     print('called config')
        --     vim.keymap.set("n", "gf", function()
        --       if require("obsidian").util.cursor_on_markdown_link() then
        --         return "<cmd>ObsidianFollowLink<CR>"
        --       else
        --         return "gf"
        --       end
        --     end, { noremap = false, expr = true })
        -- end
    }
}

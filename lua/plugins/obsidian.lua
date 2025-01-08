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
        config = function()
            local obsidian = require('obsidian')

            obsidian.setup {
                workspaces = {
                    {
                        name = "personal",
                        path = "~/MEGAsync/POWER",
                    },
                    {
                        name = "work",
                        path = "~/MEGAsync/WorkVault",
                    },
                },

                notes_subdir = "Base",

                daily_notes = {
                    folder = "daily"
                },

                templates = {
                    folder = "Templates"
                },

                mappings = {
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
                    },
                },
                attachments = {
                    img_folder = "files",
                },

                ---@return table
                note_frontmatter_func = function(note)
                    -- Add the title of the note as an alias.
                    if note.title then
                        note:add_alias(note.title)
                    end

                    -- local out = { id = note.id, aliases = note.aliases, tags = note.tags }
                    local out = {}

                    -- `note.metadata` contains any manually added fields in the frontmatter.
                    -- So here we just make sure those fields are kept in the frontmatter.
                    if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                        for k, v in pairs(note.metadata) do
                            out[k] = v
                        end
                    end

                    return out
                end,
            }

            keymap("n", "<leader>oo", "<CMD>ObsidianOpen<CR>", { desc = "Open the current note in obsidian" })
            keymap("n", "<leader>ob", "<CMD>ObsidianBacklinks<CR>", { desc = "Find backlinks to the note" })
            keymap("n", "<leader>ol", "<CMD>ObsidianLinks<CR>", { desc = "Find links in the note" })
            keymap("n", "<leader>os", "<CMD>ObsidianTOC<CR>", { desc = "Show the table of contents" })
            keymap("n", "<leader>of", "<CMD>ObsidianQuickSwitch<CR>", { desc = "Open quick switch" })
            keymap("n", "<leader>og", "<CMD>ObsidianSearch<CR>", { desc = "Find in notes" })
            keymap("n", "<leader>ot", "<CMD>ObsidianTemplate<CR>", { desc = "Insert a template" })
            keymap("n", "<leader>oe", "<CMD>ObsidianExtractNote<CR>",
                { desc = "Extract the visual text into a new note and linq to it" })
        end
    }
}

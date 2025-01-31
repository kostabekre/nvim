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

                disable_frontmatter = true,
                notes_subdir = "Base",
                new_notes_location = "notes_subdir",

                daily_notes = {
                    folder = "Daily"
                },

                templates = {
                    folder = "Templates"
                },

                  -- Optional, customize how note IDs are generated given an optional title.
                  ---@param title string|?
                  ---@return string
                  note_id_func = function(title)
                      local suffix = tostring(os.date("%Y%m%d%H%M"))
                      if title ~= nil then
                          -- If title is given, transform it into valid file name.
                          return suffix .. " " .. title
                      else
                          return suffix
                      end
                  end,
                  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
                  -- URL it will be ignored but you can customize this behavior here.
                  ---@param url string
                  follow_url_func = function(url)
                      -- Open the URL in the default web browser.
                      -- vim.fn.jobstart({"open", url})  -- Mac OS
                      vim.fn.jobstart({"xdg-open", url})  -- linux
                      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
                      -- vim.ui.open(url) -- need Neovim 0.10.0+
                  end,

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
                    img_folder = "Files",
                },
            }

            keymap("n", "<leader>oo", "<CMD>ObsidianOpen<CR>", { desc = "Open the current note in obsidian" })
            keymap("n", "<leader>ob", "<CMD>ObsidianBacklinks<CR>", { desc = "Find backlinks to the note" })
            keymap("n", "<leader>ol", "<CMD>ObsidianLinks<CR>", { desc = "Find links in the note" })
            keymap("n", "<leader>os", "<CMD>ObsidianTOC<CR>", { desc = "Show the table of contents" })
            keymap("n", "<leader>of", "<CMD>ObsidianQuickSwitch<CR>", { desc = "Open quick switch" })
            keymap("n", "<leader>og", "<CMD>ObsidianSearch<CR>", { desc = "Find in notes" })
            keymap("n", "<leader>ot", "<CMD>ObsidianTemplate<CR>", { desc = "Insert a template" })
            keymap({"n", "v"}, "<leader>oe", "<CMD>ObsidianExtractNote ",{ desc = "Extract the visual text into a new note and linq to it" })
            keymap("n", "<leader>on", "<CMD>ObsidianNew<CR>", {desc = "Create a new note"})
        end
    }
}

return {
	{
		dir = "~/source/neovim/plugins/obsidian.nvim",
		dev = false,
		"obsidian-nvim/obsidian.nvim",
		-- version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		event = {
			-- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
			-- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
			-- refer to `:h file-pattern` for more examples
			"BufReadPre "
				.. vim.fn.expand("~")
				.. "/Documents/PowerVault/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/PowerVault/*.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/WorkVault/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/WorkVault/*.md",
			"BufReadPre " .. vim.fn.expand("~") .. "/Documents/TestVault/*.md",
			"BufNewFile " .. vim.fn.expand("~") .. "/Documents/TestVault/*.md",
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local obsidian = require("obsidian")

			obsidian.setup({
				workspaces = {
					{
						name = "personal",
						path = "~/Documents/PowerVault",
					},
					{
						name = "work",
						path = "~/Documents/WorkVault",
					},
					{
						name = "test",
						path = "~/Documents/TestVault",
					},
				},

				---@return table
				note_frontmatter_func = function(note)
					local out = { aliases = note.aliases, tags = note.tags }

					if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
						for k, v in pairs(note.metadata) do
							if k == "updated" then
								v = tostring(os.date("%Y-%m-%dT%H:%M"))
							end

							out[k] = v
						end
					end

					if not out["parent"] then
						out["parent"] = ""
					end

					return out
				end,

				notes_subdir = "Base",
				new_notes_location = "current_dir",

				-- Optional, sort search results by "path", "modified", "accessed", or "created".
				-- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
				-- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
				sort_by = "modified",
				sort_reversed = true,

				daily_notes = {
					folder = "Daily",
				},

				templates = {
					folder = "Templates",
					date_format = "%Y-%m-%dT%H:%M",
					substitutions = {
						custom_title = function()
							--local file_name = require("obsidian").Note.name
							--print(file_name)
							return "test"
							--local name_only = file_name:sub(0, #file_name - 3)
							--return string.gmatch(name_only, " ")[1];
						end,
					},
				},

				-- Optional, customize how note IDs are generated given an optional title.
				---@param title string|?
				---@return string
				note_id_func = function(title)
					if title ~= nil then
						return title
					else
						local suffix = tostring(os.date("%Y-%m-%d"))
						return suffix
					end
				end,
				-- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
				-- URL it will be ignored but you can customize this behavior here.
				---@param url string
				follow_url_func = function(url)
					vim.fn.jobstart({ "xdg-open", url }) -- linux
					-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
					-- vim.ui.open(url) -- need Neovim 0.10.0+
				end,

				-- follow_img_func = function(img)
				-- vim.fn.jobstart { "qlmanage", "-p", img }  -- Mac OS quick look preview
				-- vim.fn.jobstart({"xdg-open", img})  -- linux
				-- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
				-- end,

				mappings = {
					["gd"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
					},
					["<C-]>"] = {
						action = function()
							return require("obsidian").util.gf_passthrough()
						end,
						opts = { noremap = false, expr = true, buffer = true },
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

				ui = {
					enable = false,
				},
			})

			keymap("n", "<leader>oo", "<CMD>ObsidianOpen<CR>", { desc = "Open the current note in obsidian" })
			keymap("n", "<leader>ob", "<CMD>ObsidianBacklinks<CR>", { desc = "Find backlinks to the note" })
			keymap("n", "<leader>ol", "<CMD>ObsidianLinks<CR>", { desc = "Find links in the note" })
			keymap("n", "<leader>os", "<CMD>ObsidianTOC<CR>", { desc = "Show the table of contents" })
			keymap("n", "<leader>of", "<CMD>ObsidianQuickSwitch<CR>", { desc = "Open quick switch" })
			keymap("n", "<leader>oa", function()
				require("config.telescope.obsidian_utility").setup()
			end, { desc = "Find aliases" })
			keymap("n", "<leader>og", "<CMD>ObsidianSearch<CR>", { desc = "Find in notes" })
			keymap("n", "<leader>ott", "<CMD>ObsidianTemplate<CR>", { desc = "Insert a template" })
			keymap("n", "<leader>or", "<CMD>ObsidianRename<CR>", { desc = "Rename the note" })
			keymap(
				{ "n", "v" },
				"<leader>oe",
				"<CMD>ObsidianExtractNote<CR>",
				{ desc = "Extract the visual text into a new note and linq to it" }
			)
			keymap("n", "<leader>on", "<CMD>ObsidianNewFromTemplate<CR>", { desc = "Create a new note" })
			keymap("n", "<leader>od", "<CMD>ObsidianDailies<CR>", { desc = "Show Dailies" })
			keymap("n", "<leader>ots", "<CMD>ObsidianTags<CR>", { desc = "Show Tags" })
		end,
	},
}

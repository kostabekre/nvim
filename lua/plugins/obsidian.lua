return {
	{
		"kostabekre/obsidian.nvim",
		-- version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		branch = "develop",
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
		},
		dependencies = {
			-- Required.
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
		},
		config = function()
			local obsidian = require("obsidian")

			obsidian.setup({
				legacy_commands = false,

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

				completion = {
					nvim_cmp = true,
					blink = false,
					create_new = false,
				},

				picker = {
					-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
					name = "telescope.nvim",
					-- Optional, configure key mappings for the picker. These are the defaults.
					-- Not all pickers support all mappings.
					note_mappings = {
						-- Create a new note from your query.
						new = "<C-x>",
						-- Insert a link to the selected note.
						insert_link = "<C-l>",
					},
					tag_mappings = {
						-- Add tag(s) to current note.
						tag_note = "<C-x>",
						-- Insert a tag at the current location.
						insert_tag = "<C-l>",
					},
				},

				---@return table
				note_frontmatter_func = function(note)
					local out = { aliases = note.aliases, tags = note.tags }

					if note.metadata and not vim.tbl_isempty(note.metadata) then
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

					if not out["created"] then
						out["created"] = tostring(os.date("%Y-%m-%dT%H:%M"))
					end

					if not out["updated"] then
						out["updated"] = tostring(os.date("%Y-%m-%dT%H:%M"))
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

				backlinks = {
					parse_headers = false,
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

				callbacks = {
					post_setup = function(_)
						vim.keymap.set("n", "<leader>gd", "<CMD>Obsidian follow_link<CR>", { desc = "Follow link" })
						vim.keymap.set(
							"n",
							"<C-]>",
							"<CMD>Obsidian follow_link<CR>",
							{ noremap = true, desc = "Follow link" }
						)
					end,
				},
				attachments = {
					img_folder = "Files",
				},

				ui = {
					enable = false,
				},
				cache = {
					enabled = true,
					path = ".cache.json",
				},

				statusline = {
					enabled = false,
				},

				---@class obsidian.config.FooterOpts
				footer = {
					enabled = true,
					--format = "{{backlinks}} backlinks  {{properties}} properties  {{words}} words  {{chars}} chars",
					format = "{{backlinks}} backlinks",
					hl_group = "Comment",
					separator = string.rep("-", 80),
				},
			})

			vim.keymap.set("n", "<leader>oo", "<CMD>Obsidian open<CR>", { desc = "Open the current note in obsidian" })
			vim.keymap.set("n", "<leader>ob", "<CMD>Obsidian backlinks<CR>", { desc = "Find backlinks to the note" })
			vim.keymap.set("n", "<leader>ol", "<CMD>Obsidian links<CR>", { desc = "Find links in the note" })
			vim.keymap.set("n", "<leader>os", "<CMD>Obsidian toc<CR>", { desc = "Show the table of contents" })
			vim.keymap.set("n", "<leader>of", "<CMD>Obsidian quick_switch<CR>", { desc = "Open quick switch" })
			vim.keymap.set("n", "<leader>og", "<CMD>Obsidian search<CR>", { desc = "Find in notes" })
			vim.keymap.set("n", "<leader>ott", "<CMD>Obsidian template<CR>", { desc = "Insert a template" })
			vim.keymap.set("n", "<leader>or", "<CMD>Obsidian rename<CR>", { desc = "Rename the note" })
			vim.keymap.set(
				{ "n", "v" },
				"<leader>oe",
				"<CMD>Obsidian extract_note<CR>",
				{ desc = "Extract the visual text into a new note and link to it" }
			)
			vim.keymap.set("n", "<leader>on", "<CMD>Obsidian new_from_template<CR>", { desc = "Create a new note" })
			vim.keymap.set("n", "<leader>op", function()
				vim.cmd("normal gg")
				vim.cmd("normal /parent")
				vim.cmd("normal n")
				vim.cmd("normal f[")
				vim.cmd("Obsidian follow_link")
			end, { desc = "Open Parent Note" })
			vim.keymap.set("n", "<leader>odd", "<CMD>Obsidian dailies<CR>", { desc = "Show Dailies" })

			vim.keymap.set("n", "<leader>odm", function()
				vim.api.nvim_cmd({ cmd = "Obsidian", args = { "quick_switch", tostring(os.date("%Y-%m.md")) } }, {})
			end, { desc = "Open Month Note" })

			vim.keymap.set("n", "<leader>odt", function()
				vim.api.nvim_cmd({ cmd = "Obsidian", args = { "today", "+1" } }, {})
			end, { desc = "Open Tommorow Note" })

			vim.keymap.set("n", "<leader>ots", "<CMD>Obsidian tags<CR>", { desc = "Show Tags" })

			-- HACK: Manage Markdown tasks in Neovim similar to Obsidian | Telescope to List Completed and Pending Tasks
			-- https://youtu.be/59hvZl077hM
			--
			-- If there is no `untoggled` or `done` label on an item, mark it as done
			-- and move it to the "## completed tasks" markdown heading in the same file, if
			-- the heading does not exist, it will be created, if it exists, items will be
			-- appended to it at the top lamw25wmal
			--
			-- If an item is moved to that heading, it will be added the `done` label
			vim.keymap.set("n", "<M-x>", function()
				-- Customizable variables
				-- NOTE: Customize the completion label
				local label_done = "done:"
				-- NOTE: Customize the timestamp format
				local timestamp = os.date("%Y-%m-%dT%H:%M")
				-- local timestamp = os.date("%y%m%d")
				-- NOTE: Customize the heading and its level
				local tasks_heading = "## Completed tasks"
				-- Save the view to preserve folds
				vim.cmd("mkview")
				local api = vim.api
				-- Retrieve buffer & lines
				local buf = api.nvim_get_current_buf()
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				local start_line = cursor_pos[1] - 1
				local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
				local total_lines = #lines
				-- If cursor is beyond last line, do nothing
				if start_line >= total_lines then
					vim.cmd("loadview")
					return
				end
				------------------------------------------------------------------------------
				-- (A) Move upwards to find the bullet line (if user is somewhere in the chunk)
				------------------------------------------------------------------------------
				while start_line > 0 do
					local line_text = lines[start_line + 1]
					-- Stop if we find a blank line or a bullet line
					if line_text == "" or line_text:match("^%s*%-") then
						break
					end
					start_line = start_line - 1
				end
				-- Now we might be on a blank line or a bullet line
				if lines[start_line + 1] == "" and start_line < (total_lines - 1) then
					start_line = start_line + 1
				end
				------------------------------------------------------------------------------
				-- (B) Validate that it's actually a task bullet, i.e. '- [ ]' or '- [x]'
				------------------------------------------------------------------------------
				local bullet_line = lines[start_line + 1]
				if not bullet_line:match("^%s*%- %[[x ]%]") then
					-- Not a task bullet => show a message and return
					print("Not a task bullet: no action taken.")
					vim.cmd("loadview")
					return
				end
				------------------------------------------------------------------------------
				-- 1. Identify the chunk boundaries
				------------------------------------------------------------------------------
				local chunk_start = start_line
				local chunk_end = start_line
				while chunk_end + 1 < total_lines do
					local next_line = lines[chunk_end + 2]
					if next_line == "" or next_line:match("^%s*%-") then
						break
					end
					chunk_end = chunk_end + 1
				end
				-- Collect the chunk lines
				local chunk = {}
				for i = chunk_start, chunk_end do
					table.insert(chunk, lines[i + 1])
				end
				------------------------------------------------------------------------------
				-- 2. Check if chunk has [done: ...] or [untoggled], then transform them
				------------------------------------------------------------------------------
				local has_done_index = nil
				local has_untoggled_index = nil
				for i, line in ipairs(chunk) do
					-- Replace `[done: ...]` -> `` `done: ...` ``
					chunk[i] = line:gsub("%[done:([^%]]+)%]", "`" .. label_done .. "%1`")
					-- Replace `[untoggled]` -> `` `untoggled` ``
					chunk[i] = chunk[i]:gsub("%[untoggled%]", "`untoggled`")
					if chunk[i]:match("`" .. label_done .. ".-`") then
						has_done_index = i
						break
					end
				end
				if not has_done_index then
					for i, line in ipairs(chunk) do
						if line:match("`untoggled`") then
							has_untoggled_index = i
							break
						end
					end
				end
				------------------------------------------------------------------------------
				-- 3. Helpers to toggle bullet
				------------------------------------------------------------------------------
				-- Convert '- [ ]' to '- [x]'
				local function bulletToX(line)
					return line:gsub("^(%s*%- )%[%s*%]", "%1[x]")
				end
				-- Convert '- [x]' to '- [ ]'
				local function bulletToBlank(line)
					return line:gsub("^(%s*%- )%[x%]", "%1[ ]")
				end
				------------------------------------------------------------------------------
				-- 4. Insert or remove label *after* the bracket
				------------------------------------------------------------------------------
				local function insertLabelAfterBracket(line, label)
					local prefix = line:match("^(%s*%- %[[x ]%])")
					if not prefix then
						return line
					end
					local rest = line:sub(#prefix + 1)
					return prefix .. " " .. label .. rest
				end
				local function removeLabel(line)
					-- If there's a label (like `` `done: ...` `` or `` `untoggled` ``) right after
					-- '- [x]' or '- [ ]', remove it
					return line:gsub("^(%s*%- %[[x ]%])%s+`.-`", "%1")
				end
				------------------------------------------------------------------------------
				-- 5. Update the buffer with new chunk lines (in place)
				------------------------------------------------------------------------------
				local function updateBufferWithChunk(new_chunk)
					for idx = chunk_start, chunk_end do
						lines[idx + 1] = new_chunk[idx - chunk_start + 1]
					end
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
				end
				------------------------------------------------------------------------------
				-- 6. Main toggle logic
				------------------------------------------------------------------------------
				if has_done_index then
					chunk[has_done_index] =
						removeLabel(chunk[has_done_index]):gsub("`" .. label_done .. ".-`", "`untoggled`")
					chunk[1] = bulletToBlank(chunk[1])
					chunk[1] = removeLabel(chunk[1])
					chunk[1] = insertLabelAfterBracket(chunk[1], "`untoggled`")
					updateBufferWithChunk(chunk)
					vim.notify("Untoggled", vim.log.levels.INFO)
				elseif has_untoggled_index then
					chunk[has_untoggled_index] = removeLabel(chunk[has_untoggled_index]):gsub(
						"`untoggled`",
						"`" .. label_done .. " " .. timestamp .. "`"
					)
					chunk[1] = bulletToX(chunk[1])
					chunk[1] = removeLabel(chunk[1])
					chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
					updateBufferWithChunk(chunk)
					vim.notify("Completed", vim.log.levels.INFO)
				else
					-- Save original window view before modifications
					local win = api.nvim_get_current_win()
					local view = api.nvim_win_call(win, function()
						return vim.fn.winsaveview()
					end)
					chunk[1] = bulletToX(chunk[1])
					chunk[1] = insertLabelAfterBracket(chunk[1], "`" .. label_done .. " " .. timestamp .. "`")
					-- Remove chunk from the original lines
					for i = chunk_end, chunk_start, -1 do
						table.remove(lines, i + 1)
					end
					-- Append chunk under 'tasks_heading'
					local heading_index = nil
					for i, line in ipairs(lines) do
						if line:match("^" .. tasks_heading) then
							heading_index = i
							break
						end
					end
					if heading_index then
						for _, cLine in ipairs(chunk) do
							table.insert(lines, heading_index + 1, cLine)
							heading_index = heading_index + 1
						end
						-- Remove any blank line right after newly inserted chunk
						local after_last_item = heading_index + 1
						if lines[after_last_item] == "" then
							table.remove(lines, after_last_item)
						end
					else
						table.insert(lines, tasks_heading)
						for _, cLine in ipairs(chunk) do
							table.insert(lines, cLine)
						end
						local after_last_item = #lines + 1
						if lines[after_last_item] == "" then
							table.remove(lines, after_last_item)
						end
					end
					-- Update buffer content
					vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
					vim.notify("Completed", vim.log.levels.INFO)
					-- Restore window view to preserve scroll position
					api.nvim_win_call(win, function()
						vim.fn.winrestview(view)
					end)
				end
				-- Write changes and restore view to preserve folds
				-- "Update" saves only if the buffer has been modified since the last save
				vim.cmd("silent update")
				vim.cmd("loadview")
			end, { desc = "[P]Toggle task and move it to 'done'" })
		end,
	},
}

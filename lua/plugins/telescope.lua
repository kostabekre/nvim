-- Search files with fzf or use a custom window for any action you want.

---@type string
local build_command

if vim.fn.has("win32") == 1 then
	-- Requires gcc or clang and make
	build_command = "make"
else
	-- Requires CMake, make, and GCC or Clang on Linux and MacOS
	build_command = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
end

return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = build_command,
			},
			{
				"nvim-telescope/telescope-frecency.nvim",
				-- install the latest stable version
				version = "*",
			},
		},
		lazy = true,
		keys = {
			"<leader>fp",
			"<leader>ff",
			"<leader>fg",
			"<leader>gf",
			"<leader>fb",
			"<leader>fp",
			"<leader>fh",
			"<leader>fr",
			"<leader>gd",
			"<leader>gt",
			"<leader>gi",
			"<leader>gr",
			"<leader>D",
			"<leader>/",
			"<leader>?",
			"<leader>fk",
		},
		opts = {
			defaults = {
				file_ignore_patterns = { ".godot", ".git" },
				preview = {
					hide_on_startup = true,
				},
				path_display = {
					shorten = 5,
				},
				mappings = {
					n = {
						["P"] = require("telescope.actions.layout").toggle_preview,
						["<C-s>"] = require("telescope.actions").select_horizontal,
						["x"] = require("telescope.actions").delete_buffer,
						["l"] = require("telescope.actions").cycle_history_next,
						["h"] = require("telescope.actions").cycle_history_prev,
					},
					i = {
						["<C-s>"] = require("telescope.actions").select_horizontal,
						["<C-i>"] = require("telescope.actions.layout").toggle_preview,
						["<C-x>"] = require("telescope.actions").delete_buffer,
					},
				},
			},
			pickers = {
				buffers = {
					sort_mru = true,
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		},

		config = function(_, opts)
			local telescope = require("telescope")
			local themes = require("telescope.themes")

			telescope.setup(opts)

			telescope.load_extension("fzf")
			telescope.load_extension("frecency")

			local telescope_builtin = require("telescope.builtin")

			-- Git
			vim.keymap.set("n", "<leader>gf", telescope_builtin.git_files, { desc = "Find git files" })
			vim.keymap.set("n", "<leader>gst", function()
				telescope_builtin.git_status({
					preview = {
						hide_on_startup = false,
					},
				})
			end, { desc = "Find git status" })
			vim.keymap.set("n", "<leader>gss", telescope_builtin.git_stash, { desc = "Find git stash" })
			vim.keymap.set("n", "<leader>gcm", telescope_builtin.git_commits, { desc = "Find git commits" })
			vim.keymap.set("n", "<leader>gbc", telescope_builtin.git_bcommits, { desc = "Find git buffer commits" })
			vim.keymap.set("n", "<leader>ggb", telescope_builtin.git_branches, { desc = "Find git branches" })

			-- Common
			vim.keymap.set("n", "<leader>ff", function()
				telescope_builtin.find_files(themes.get_ivy(opts))
			end, { desc = "Find files" })
			vim.keymap.set(
				"n",
				"<leader>fp",
				"<CMD>Telescope frecency workspace=CWD path_display={'shorten'}<CR>",
				{ desc = "Previous Files" }
			)

			vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "Find in files" })
			vim.keymap.set("n", "<leader>/", telescope_builtin.current_buffer_fuzzy_find, { desc = "Find in buffer" })
			vim.keymap.set("n", "<leader>fb", function()
				telescope_builtin.buffers(themes.get_dropdown(opts))
			end, { desc = "Find buffers" })
			vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "Find help tags" })
			vim.keymap.set("n", "<leader>fr", telescope_builtin.resume, { desc = "Find previous" })
			vim.keymap.set("n", "<leader>fk", telescope_builtin.keymaps, { desc = "Find keymaps" })
		end,
	},
}

return {
	{
		{
			"ThePrimeagen/harpoon",
			branch = "harpoon2",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
			},
			keys = { "<leader>a", "<C-e>", "<C-h>", "<C-t>", "<C-n>", "<C-g>", "<C-S-P>", "<C-S-N>" },
			config = function()
				local harpoon = require("harpoon")

				harpoon:setup()

				vim.keymap.set("n", "<leader>a", function()
					harpoon:list():add()
				end, { desc = "Add to harpoon list" })

				vim.keymap.set("n", "<leader>hi", function()
					harpoon:list():select(1)
				end, { desc = "Go to fIrst harpoon item" })

				vim.keymap.set("n", "<leader>hc", function()
					harpoon:list():select(2)
				end, { desc = "Go to seCond harpoon item" })

				vim.keymap.set("n", "<leader>hh", function()
					harpoon:list():select(3)
				end, { desc = "Go to tHird harpoon item" })

				vim.keymap.set("n", "<leader>hf", function()
					harpoon:list():select(4)
				end, { desc = "Go to Fourth harpoon item" })

				-- Toggle previous & next buffers stored within Harpoon list
				vim.keymap.set("n", "<C-S-P>", function()
					harpoon:list():prev()
				end)
				vim.keymap.set("n", "<C-S-N>", function()
					harpoon:list():next()
				end)

				local conf = require("telescope.config").values
				local function toggle_telescope(harpoon_files)
					local file_paths = {}
					for _, item in ipairs(harpoon_files.items) do
						table.insert(file_paths, item.value)
					end

					require("telescope.pickers")
						.new({}, {
							prompt_title = "Harpoon",
							finder = require("telescope.finders").new_table({
								results = file_paths,
							}),
							previewer = conf.file_previewer({}),
							sorter = conf.generic_sorter({}),
						})
						:find()
				end

				vim.keymap.set("n", "<leader>he", function()
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end)
				-- vim.keymap.set("n", "<C-e>", function()
				-- 	toggle_telescope(harpoon:list())
				-- end, { desc = "Open harpoon window" })
			end,
		},
	},
}

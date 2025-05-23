return {
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      local wanted_linters_by_ft = {
        gdscript = { "gdlint" },
        html = { "htmlhint" },
        javascript = { "standardjs" },
        lua = { "luacheck" },
      }

      local existing_linters_per_ft = {}
      local mason_registry = require("mason-registry")

      for key, list_of_linters in pairs(wanted_linters_by_ft) do
        local founded_linters = {}

        for _, linter in ipairs(list_of_linters) do
          if mason_registry.is_installed(linter) then
            table.insert(founded_linters, linter)
          end
        end

        existing_linters_per_ft[key] = founded_linters
      end

      lint.linters_by_ft = existing_linters_per_ft

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })

      vim.keymap.set("n", "<leader>ll", function()
        lint.try_lint()
      end, { desc = "Trigger linting manually" })

      vim.keymap.set("n", "<leader>li", function()
        local linters = lint.linters

        print("TODO: show if linter installed for the current file type.")
      end, { desc = "Show running linters" })
    end,
  },
}

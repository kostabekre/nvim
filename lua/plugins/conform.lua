return {
  "stevearc/conform.nvim",
  ft = {
    "lua",
    "cs",
    "typescriptreact",
    "python",
    "javascript"
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        lua = { "stylua" },
        cs = { "csharpier" },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
        -- You can customize some of the format options for the filetype (:help conform.format)
        -- rust = { "rustfmt", lsp_format = "fallback" },
        -- Conform will run the first available formatter
        javascript = { "prettierd", "prettier", stop_after_first = true },
      },
      formatters = {
        stylua = {
          cwd = require("conform.util").root_file({ ".stylua.toml" })
        }
      },
      format_on_save = {
        -- These options will be passed to conform.format()
        timeout_ms = 500,
        lsp_format = "fallback",
      },
    })
  end,
}

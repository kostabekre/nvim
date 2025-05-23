return {
  "nicholasmata/nvim-dap-cs",
  dependencies = { "mfussenegger/nvim-dap", "mason-org/mason.nvim" },
  ft = {
    "cs",
  },
  config = function()
    local mason_registry = require("mason-registry")
    local have_netcoredbg = mason_registry.is_installed("netcoredbg")

    if have_netcoredbg then
      require("dap-cs").setup({
        netcorebg = {
          path = vim.fn.expand("$MASON/bin/netcoredbg"),
        },
      })
    else
      print("netcoredbg is not installed!")
    end
  end,
}

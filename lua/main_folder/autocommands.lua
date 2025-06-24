local lsp_group = vim.api.nvim_create_augroup("DefaultLspAttach", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil
        or client.name == "render-markdown"
        or client.name == "ltex_plus" then
      return
    end

    vim.diagnostic.config({
      float = {
        source = true,
        border = "rounded",
      },
    })

    vim.keymap.set("n", "<leader>gr", function()
      require("telescope.builtin").lsp_references({ fname_width = 40, include_declaration = false })
    end, { desc = "Show LSP References" })

    vim.keymap.set("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

    vim.keymap.set("n", "<leader>gd", function()
      require("telescope.builtin").lsp_definitions({})
    end, { desc = "Go to LSP definitions" })

    vim.keymap.set(
      "n",
      "<leader>gi",
      "<cmd>Telescope lsp_implementations<CR>",
      { desc = "Go to LSP implementations" }
    )

    vim.keymap.set(
      "n",
      "<leader>gt",
      "<cmd>Telescope lsp_type_definitions<CR>",
      { desc = "Go to LSP type definitions" }
    )

    vim.keymap.set("n", "<leader>fo", function()
      require("telescope.builtin").lsp_document_symbols({ symbols = "function" })
    end, { desc = "Go to LSP functions" })

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "See available code actions" })

    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Smart rename" })

    vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics<CR>", { desc = "Show buffer Diagnostics" })

    vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "Show Line Diagnostics" })

    vim.keymap.set("n", "<leader>dk", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Go to Previous Diagnostic" })

    vim.keymap.set("n", "<leader>dj", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Go to Next Diagnostic" })

    vim.keymap.set("n", "K", function()
      vim.lsp.buf.hover({
        border = "rounded",
      })
    end, { desc = "Show Documentation", buffer = true })

    vim.keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", { desc = "LSP Restart" })
    vim.keymap.set("n", "<leader>th", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { desc = "Toggle inlay hints" })
  end,
})

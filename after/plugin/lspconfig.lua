local ls_ok_result, lspconfig = pcall(require, "lspconfig")
if not ls_ok_result then
    print("lspconfig config is not founded")
    return
end

local cmp_ok_result, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_ok_result then
    print("cmp_nvim_lsp config is not founded")
    return
end

local opts = { noremap = true, silent = true }

local on_attach = function (client, bufnr)
    opts.buffer = bufnr

    opts.desc = "Show LSP References"
    keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)

    opts.desc = "Go to Declaration"
    keymap("n", "gD", vim.lsp.buf.declaration, opts)

    opts.desc = "Go to LSP definitions"
    keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

    opts.desc = "Go to LSP implementations"
    keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

    opts.desc = "Go to LSP type definitions"
    keymap("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

    opts.desc = "See available code actions"
    keymap({"n", "v"}, "<leader>ca", vim.lsp.buf.code_action, opts)

    opts.desc = "Smart rename"
    keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)

    opts.desc = "Show buffer Diagnostics"
    keymap("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

    opts.desc = "Show Line Diagnostics"
    keymap("n", "<leader>d", vim.diagnostic.open_float, opts)

    opts.desc = "Go to Previous Diagnostic"
    keymap("n", "<leader>[d", vim.diagnostic.goto_prev, opts)

    opts.desc = "Go to Next Diagnostic"
    keymap("n", "<leader>]d", vim.diagnostic.goto_next, opts)

    opts.desc = "Show Documentation"
    keymap("n", "<leader>K", vim.lsp.buf.hover, opts)

    opts.desc = "LSP Restart"
    keymap("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
end

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.gdscript.setup {
    capabilities = capabilities,
    on_attach = on_attach
}


lspconfig.lua_ls.setup {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path..'/.luarc.json') or vim.uv.fs_stat(path..'/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          -- Depending on the usage, you might want to add additional paths here.
          "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

local util = require 'lspconfig.util'
local csharp_ls_extended = require 'csharpls_extended'

lspconfig.csharp_ls.setup{
    cmd = { 'csharp-ls' },
    capabilities = capabilities,
    handlers = {
        ["textDocument/definition"] = csharp_ls_extended.handler,
        ["textDocument/typeDefinition"] = csharp_ls_extended.handler,
    },
    on_attach = on_attach,
    root_dir = function(fname)
      return util.root_pattern '*.sln'(fname) or util.root_pattern '*.csproj'(fname)
    end,
    filetypes = { 'cs' },
    init_options = {
      AutomaticWorkspaceInit = true,
    },
}

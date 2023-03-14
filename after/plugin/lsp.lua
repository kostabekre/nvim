local lsp = require('lsp-zero').preset({
    
  name = 'minimal',
  set_lsp_keymaps = {omit = {'<F4>'}},
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

 lsp.ensure_installed({
	'omnisharp',
 })

local cmp = require('cmp')
local cmp_select  = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
	['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
	['<C-y>'] = cmp.mapping.confirm({select = true}),
	['<C-Space>'] = cmp.mapping.complete(),
})

lsp.setup_nvim_cmp({
	mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr}
  local bind = vim.keymap.set

  bind('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
  bind('n', '<leader>a', function() vim.lsp.buf.code_action() end, opts)
end)

lsp.setup()

require("mason-nvim-dap").setup({
    automatic_setup = true,
})

require 'mason-nvim-dap'.setup_handlers {}

require("main_folder")

-- Install lazy if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        "nvim-treesitter/nvim-treesitter", build = ":TSUpdate"
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'mbbill/undotree', -- history of undos
    'theprimeagen/harpoon',

    'terrortylor/nvim-comment',
    'windwp/nvim-autopairs', 
    'kylechui/nvim-surround',

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {                                      -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip'},     -- Required
    }
  },

  'hrsh7th/cmp-buffer',
'hrsh7th/cmp-path',
'hrsh7th/cmp-cmdline',
'saadparwaiz1/cmp_luasnip',

    {
        '4513ECHO/vim-colors-hatsunemiku', -- color 
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function() 
            vim.cmd([[colorscheme hatsunemiku]])
        end,
    },
    'tpope/vim-fugitive', -- git wrapper
    'Eandrju/cellular-automaton.nvim', -- just for fun
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
    },
    'windwp/nvim-ts-autotag'
})

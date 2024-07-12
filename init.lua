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
        tag = '0.1.8',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'mbbill/undotree', -- history of undos

    'terrortylor/nvim-comment',
    'windwp/nvim-autopairs', 
    'kylechui/nvim-surround',

    'tpope/vim-dadbod', -- SQL UI

    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        dependencies = { 
            "rafamadriz/friendly-snippets" ,
        },
    },

    -- Autocompletion
    'hrsh7th/nvim-cmp',     -- Required
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',

    'neovim/nvim-lspconfig',

    'hrsh7th/cmp-nvim-lsp', 

    {
        'williamboman/mason.nvim',
        config = function ()
            require('mason').setup()
        end
    },
    'williamboman/mason-lspconfig.nvim', 

    '4513ECHO/vim-colors-hatsunemiku', -- color 

    'tpope/vim-fugitive', -- git wrapper

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        opts = {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
    },

    'lambdalisue/suda.vim',

    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', 
            'nvim-tree/nvim-web-devicons',     
        }
    },
})

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
        tag = '0.1.5',
        dependencies = {
            'nvim-lua/plenary.nvim'
        }
    },
    'mbbill/undotree', -- history of undos

    'terrortylor/nvim-comment',
    'windwp/nvim-autopairs', 
    'kylechui/nvim-surround',
    'williamboman/mason.nvim',
    'tpope/vim-dadbod',
    {
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp"
    },
    'williamboman/mason-lspconfig.nvim', -- Optional
    -- Autocompletion
    'hrsh7th/nvim-cmp',     -- Required
    'hrsh7th/cmp-nvim-lsp', -- Required
    'neovim/nvim-lspconfig',

    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',

    'MunifTanjim/prettier.nvim',
    'jose-elias-alvarez/null-ls.nvim',

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
    'windwp/nvim-ts-autotag',

    'lambdalisue/suda.vim',

    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {

        "glepnir/lspsaga.nvim",
        event = "LspAttach",
        config = function()
            require("lspsaga").setup({})
        end,
    },
})

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

--- Search for Godot Project
local projectfile = vim.fn.getcwd() .. '/project.godot'
if projectfile then
    vim.fn.serverstart './godothost'
end

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
    -- 'kylechui/nvim-surround',

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

    -- 'tpope/vim-fugitive', -- git wrapper

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

    --- gdscript (better highlight and intend)
    {
        'habamax/vim-godot',
        event = "BufEnter *.gd"
    },

    'lambdalisue/suda.vim',

    'Hoffs/omnisharp-extended-lsp.nvim',

    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',

            -- Required dependency for nvim-dap-ui
            'nvim-neotest/nvim-nio',

            -- Installs the debug adapters for you
            'williamboman/mason.nvim',
            'jay-babu/mason-nvim-dap.nvim',

            -- Add your own debuggers here
            'leoluz/nvim-dap-go',
        }
    }
})

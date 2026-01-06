return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "saadparwaiz1/cmp_luasnip",
        },
        event = {
            "InsertEnter",
            "CmdlineEnter",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            vim.opt.shortmess:append("c")

            vim.keymap.set("i", "<C-space>", "<nop>")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-p>"] = cmp.mapping.select_prev_item(),
                    ["<C-n>"] = cmp.mapping.select_next_item(),
                    ["<C-y>"] = cmp.mapping(
                        cmp.mapping.confirm({
                            behavior = cmp.ConfirmBehavior.Insert,
                            select = true,
                        }),
                        { "i", "c" }
                    ),
                    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),

                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<C-space>"] = cmp.mapping.complete(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "render-markdown" },
                    { name = "path" },
                    { name = "buffer" },
                }),
            })

            -- Setup up vim-dadbod
            cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
                sources = {
                    { name = "vim-dadbod-completion" },
                    { name = "buffer" },
                },
            })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`,
            -- this won't work anymore).
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
                matching = { disallow_symbol_nonprefix_matching = false },
            })

            -- TODO what is happening
            -- luasnip.config.set_config {
            --     history = false,
            --     updateevents = "TextChagned,TextChangedI",
            -- }

            -- TODO add custom snippets https://www.youtube.com/watch?v=22mrSjknDHI
            -- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
            --     loadfile(ft_path)
            -- end
            --
            -- luasnip is an snippet engine, but by default it is empty,
            -- so we add common snippets.
            require("luasnip.loaders.from_vscode").lazy_load()

            vim.keymap.set({ "i", "s" }, "<C-K>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-J>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { silent = true })
        end,
    },
}

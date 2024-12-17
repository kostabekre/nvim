local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
    print('cmp is not installed!')
    return
end

local status_ok_2, luasnip = pcall(require, 'luasnip')
if not status_ok_2 then
    print('luasnip is not installed!')
    return
end

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append "c"

-- require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup{
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping(
            cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true
                },
                {"i", "c"}
        ),

        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- ['<C-e>'] = cmp.mapping.abort(),
    }),

    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'path' },
        { name = 'buffer' },
    },
}

-- TODO what is happening
-- luasnip.config.set_config {
--     history = false,
--     updateevents = "TextChagned,TextChangedI",
-- }

-- TODO add custom snippets https://www.youtube.com/watch?v=22mrSjknDHI
-- for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
--     loadfile(ft_path)
-- end

vim.keymap.set({ "i", "s" }, "c-k>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, {silent = true })

vim.keymap.set({ "i", "s" }, "c-j>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, {silent = true })

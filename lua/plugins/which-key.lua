return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 500
        end,
        config = function()
            local wk = require("which-key")
            wk.add({
                {"gcc", desc = "Comment current line" },
                {"gc{count{motion}}", desc =  "Comment given motion n times"},
                {"gc{motion}", desc =  "Comment given motion"},
                {"<leader>ff", desc = "Find Files"}
            })
        end,
        opts = {
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps.",
            },
        }
    },
}

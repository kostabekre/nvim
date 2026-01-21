return {
    {
        "nvim-mini/mini.nvim",
        version = false,
        config = function()
            local working_directory = vim.uv.cwd()

            if working_directory ~= "/home/frainx8/source/obsidian.nvim" then
                return
            end

            require("mini.test").setup()
        end,
    },
}

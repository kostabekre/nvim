vim.api.nvim_create_autocmd("BufRead", {
    desc = "Set intend rules for gdscript files",
    pattern = "*.gd",
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
        vim.opt_local.softtabstop = 2
	end
})

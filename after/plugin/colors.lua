function ColorMyEditor(color)
	color = color or "default"
    local status_ok, _ = pcall(vim.cmd, "colorscheme " .. color)
    if not status_ok then
        print("color scheme " .. color .. " is not found!") 
        return
    end

	vim.api.nvim_set_hl(0, "Normal", { bg = "none"})
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none"})
end

ColorMyEditor("hatsunemiku")

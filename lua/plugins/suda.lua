if vim.fn.has('unix') == 0 then
    print("If you want to use sudo, install gsudo")
end

return {
    'lambdalisue/suda.vim',
    cmd = { "SudaRead", "SudaWrite" }
}

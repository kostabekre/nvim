local status_ok, surround = pcall(require, 'nvim-surround')
if not status_ok then
    print('nvim-surround is not installed!')
    return
end

surround.setup{}

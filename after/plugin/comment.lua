local status_ok, comment = pcall(require, 'nvim_comment')
if not status_ok then
    print('nvim_comment is not installed!')
    return
end

comment.setup{}

local status_ok, builtin = pcall(require, 'telescope.builtin')
if not status_ok then
    print("telescope is not installed!")
    return
end

keymap('n', '<leader>ff', builtin.find_files, {})
keymap('n', '<leader>gf', builtin.git_files, {})
keymap('n', '<leader>fg', builtin.live_grep, {})
keymap('n', '<leader>fb', builtin.buffers, {})
keymap('n', '<leader>fh', builtin.help_tags, {})

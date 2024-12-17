local status_ok, telescope_builtin = pcall(require, 'telescope.builtin')
if not status_ok then
    print("telescope is not installed!")
    return
end

local status_ok_telescope, telescope = pcall(require, 'telescope')
if not status_ok_telescope then
    print("telescope is not installed!")
    return
end

telescope.setup {
    defaults = {
        file_ignore_patterns = {".godot"}
    }
}

keymap('n', '<leader>ff', telescope_builtin.find_files, {})
keymap('n', '<leader>fg', telescope_builtin.git_files, {})
keymap('n', '<leader>fg', telescope_builtin.live_grep, {})
keymap('n', '<leader>fb', telescope_builtin.buffers, {})
keymap('n', '<leader>fh', telescope_builtin.help_tags, {})

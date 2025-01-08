return {
    {
        'habamax/vim-godot',
        ft = "gdscript",
        config = function()
            local projectfile = vim.fn.getcwd() .. '/project.godot'

            if vim.fn.filereadable(projectfile) == 1 then
                vim.fn.serverstart './godothost'
            end

            local status_ok, dap = pcall(require, 'dap')
            if not status_ok then
                print('nvim-dap is not installed!')
                return
            end

            print ('heelo from godot plugin')
            dap.adapters.godot = {
                type = 'server',
                host = '127.0.0.1',
                port = 6007,
            }

            dap.configurations.gdscript = {
                {
                    type = 'godot',
                    request = 'launch',
                    name = 'Lauch scene',
                    project = '${workspaceFolder}',
                    launch_scene = true
                }
            }
        end
    },
}

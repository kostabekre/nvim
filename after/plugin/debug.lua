local status_ok, dap = pcall(require, 'dap')
if not status_ok then
    print('nvim-dap is not installed!')
    return
end

local status_ok, dapui = pcall(require, 'dapui')
if not status_ok then
    print('nvim-dap is not installed!')
    return
end

dap.keys = {
    -- Basic debugging keymaps, feel free to change to your liking!
    {
        '<F5>',
        function()
            require('dap').continue()
        end,
        desc = 'Debug: Start/Continue',
    },
    {
        '<F11>',
        function()
            require('dap').step_into()
        end,
        desc = 'Debug: Step Into',
    },
    {
        '<F10>',
        function()
            require('dap').step_over()
        end,
        desc = 'Debug: Step Over',
    },
    {
        'shift + <F11>',
        function()
            require('dap').step_out()
        end,
        desc = 'Debug: Step Out',
    },
    {
        '<leader>b',
        function()
            require('dap').toggle_breakpoint()
        end,
        desc = 'Debug: Toggle Breakpoint',
    },
    {
        '<leader>B',
        function()
            require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
    },
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    {
        '<F7>',
        function()
            require('dapui').toggle()
        end,
        desc = 'Debug: See last session result.',
    },
}

require('mason-nvim-dap').setup {
    automatic_installation = true,

    handlers = {},

    ensure_installed = {
    }
}

dapui.setup {
  -- Set icons to characters that are more likely to work in every terminal.
  --    Feel free to remove or use ones that you like more! :)
  --    Don't feel like these are good choices.
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

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

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

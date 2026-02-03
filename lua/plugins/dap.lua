return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",

            -- Required dependency for nvim-dap-ui
            "nvim-neotest/nvim-nio",

            -- Installs the debug adapters for you
            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",

            -- Add your own debuggers here
            -- 'leoluz/nvim-dap-go',
        },
        keys = {
            "<F5>",
            "<F10>",
            "<F11>",
            "shift + <F11>",
            "<F12>",
            "<leader>B",
            "<leader>lp",
            "<leader>dr",
            "<leader>dl",
            "<leader>dh",
            "<leader>dp",
            "<leader>df",
            "<leader>ds",
        },
        config = function()
            local status_ok, dap = pcall(require, "dap")
            if not status_ok then
                print("nvim-dap is not installed!")
                return
            end

            local status_ok_ui, dapui = pcall(require, "dapui")
            if not status_ok_ui then
                print("nvim-dap is not installed!")
                return
            end

            -- Keymaps for controlling the debugger
            vim.keymap.set("n", "dq", function()
                dap.terminate()
                dap.clear_breakpoints()
            end, { desc = "Terminate and clear breakpoints" })

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out" })
            vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
            vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt)" })
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
            vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame" })
            vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame" })
        end,
    },
}

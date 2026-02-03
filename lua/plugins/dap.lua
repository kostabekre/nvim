return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",

            "williamboman/mason.nvim",
            "jay-babu/mason-nvim-dap.nvim",
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

            -- Keymaps for controlling the debugger
            vim.keymap.set("n", "<leader>dq", function()
                dap.terminate()
                dap.clear_breakpoints()
            end, { desc = "Terminate and clear breakpoints" })

            vim.keymap.set("n", "<F5>", dap.continue, { desc = "Start/continue debugging DAP" })
            vim.keymap.set("n", "<F10>", dap.step_over, { desc = "Step over DAP" })
            vim.keymap.set("n", "<F11>", dap.step_into, { desc = "Step into DAP" })
            vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Step out DAP" })
            vim.keymap.set("n", "<leader>B", dap.toggle_breakpoint, { desc = "Toggle breakpoint DAP" })
            vim.keymap.set("n", "<leader>dO", dap.step_over, { desc = "Step over (alt) DAP" })
            vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Run to cursor DAP" })
            vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle DAP REPL" })
            vim.keymap.set("n", "<leader>dj", dap.down, { desc = "Go down stack frame DAP" })
            vim.keymap.set("n", "<leader>dk", dap.up, { desc = "Go up stack frame DAP" })

            -- Inspecting state
            vim.keymap.set("n", "<leader>sk", function()
                require("dap.ui.widgets").hover()
            end, { desc = "Value of expression under cursor DAP" })

            local status_ok_ui, dapui = pcall(require, "dapui")
            if not status_ok_ui then
                print("nvim-dap is not installed!")
                return
            end

            require("dapui").setup()

            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end
        end,
    },
}

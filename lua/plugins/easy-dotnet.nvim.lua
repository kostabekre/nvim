return {
    {
        "GustavEikaas/easy-dotnet.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
        enabled = true,
        -- scan current directory for sln, slnx and csproj
        cond = function(_)
            local files = vim.fn.glob(vim.fn.getcwd() .. "/*", false, true)

            local files_only = vim.tbl_filter(function(path)
                return vim.fn.isdirectory(path) == 0
            end, files)

            for _, file in ipairs(files_only) do
                local ext = file:match("^.+%.(.+)$")

                if not ext then
                    goto continue
                end

                local allowed_types = { sln = true, slnx = true, csproj = true }

                if allowed_types[ext] then
                    return true
                end

                ::continue::
            end

            return false
        end,
        opts = {
            auto_bootstrap_namespace = {
                --block_scoped, file_scoped
                type = "file_scoped",
                enabled = true,
                use_clipboard_json = {
                    behavior = "prompt", --'auto' | 'prompt' | 'never',
                    register = "+", -- which register to check
                },
            },
            lsp = {
                enabled = false,
            },
            debugger = {
                bin_path = vim.fn.exepath("netcoredbg"),
            },
            picker = "telescope",
            ---@type TestRunnerOptions
            test_runner = {
                auto_start_testrunner = true,
                hide_legend = false,
                -- Set to true when using neotest to avoid duplicate signs and conflicting buffer keymaps.
                neotest_integration = false,
                ---@type "split" | "vsplit" | "float" | "buf"
                viewmode = "float",
                ---@type number|nil
                vsplit_width = nil,
                ---@type string|nil "topleft" | "topright"
                vsplit_pos = nil,
                icons = {
                    passed = "",
                    skipped = "",
                    failed = "",
                    success = "",
                    reload = "",
                    test = "",
                    sln = "󰘐",
                    project = "󰘐",
                    dir = "",
                    package = "",
                    class = "",
                    build_failed = "󰒡",
                },
                mappings = {
                    run_test_from_buffer = { lhs = "<leader>tb", desc = "run test from buffer" },
                    run_all_tests_from_buffer = { lhs = "<leader>ta", desc = "Run all tests in file" },
                    get_build_errors = { lhs = "<leader>be", desc = "get build errors" },
                    peek_stack_trace_from_buffer = { lhs = "<leader>sp", desc = "peek stack trace from buffer" },
                    debug_test_from_buffer = { lhs = "<leader>tdb", desc = "run test from buffer" },
                    debug_test = { lhs = "<leader>tda", desc = "debug test" },
                    go_to_file = { lhs = "<leader>g", desc = "go to file" },
                    run_all = { lhs = "<leader>R", desc = "run all tests" },
                    run = { lhs = "<leader>r", desc = "run test" },
                    peek_stacktrace = { lhs = "<leader>p", desc = "peek stacktrace of failed test" },
                    expand = { lhs = "o", desc = "expand" },
                    expand_node = { lhs = "E", desc = "expand node" },
                    collapse_all = { lhs = "W", desc = "collapse all" },
                    close = { lhs = "q", desc = "close testrunner" },
                    refresh_testrunner = { lhs = "<C-r>", desc = "refresh testrunner" },
                    cancel = { lhs = "<C-c>", desc = "cancel in-flight operation" },
                    next_failure = { lhs = "]f", desc = "jump to next failing test" },
                    prev_failure = { lhs = "[f", desc = "jump to previous failing test" },
                },
            },
        },
        config = true,
    },
}

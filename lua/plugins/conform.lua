-- Formats a file with given formatters or with LSP if there is no formatter available.

local get_long_running_formatters = function(bufnr)
    local conform = require("conform")

    local formatters = conform.list_formatters(bufnr)

    local has_long_running_formatters = vim.iter(formatters):any(function(f)
        return f.command == "csharpier"
    end)

    return has_long_running_formatters
end

return {
    "stevearc/conform.nvim",
    ft = {
        "lua",
        "cs",
        "typescriptreact",
        "python",
        "javascript",
        "json",
        "yaml",
    },
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                typescriptreact = { "prettierd", "prettier", stop_after_first = true },
                -- Conform will run multiple formatters sequentially
                python = { "isort", "black" },
                -- You can customize some of the format options for the filetype (:help conform.format)
                -- rust = { "rustfmt", lsp_format = "fallback" },
                -- Conform will run the first available formatter
                javascript = { "prettierd", "prettier", stop_after_first = true },
                -- disabled because save becomes slow, it's better to use in precommit instead
                -- gdscript = { "gdformat" },
                json = { "jq" },
                yaml = { "yamlfmt" },
                ["*"] = { "codespell" },
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = function(bufnr)
                return not get_long_running_formatters(bufnr)
                        and {
                            lsp_format = "fallback",
                            timeout_ms = 500,
                        }
                    or nil
            end,
            format_after_save = function(bufnr)
                return get_long_running_formatters(bufnr)
                        and {
                            lsp_format = "fallback",
                        }
                    or nil
            end,
            log_level = vim.log.levels.ERROR,
            -- Conform will notify you when a formatter errors
            notify_on_error = true,
            -- Conform will notify you when no formatters are available for the buffer
            notify_no_formatters = true,
            formatters = {
                stylua = {
                    cwd = require("conform.util").root_file({ ".stylua.toml" }),
                },
                csharpier = {
                    command = "csharpier",
                    args = { "format", "$FILENAME", "--write-stdout" },
                },
                cwd = require("conform.util").root_file({ ".gitignore" }),
            },
        })
        local cs_interpise_projects = string.find(vim.uv.cwd(), "panelapps")

        if cs_interpise_projects == nil then
            require("conform").formatters_by_ft.cs = { "csharpier" }
        end
    end,
}

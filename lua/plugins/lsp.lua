return {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local mason_registry = require("mason-registry")

        local default_capabilities = require("cmp_nvim_lsp").default_capabilities()
        -- local default_capabilities = require("blink.cmp").get_lsp_capabilities()

        if mason_registry.is_installed("html") then
            vim.lsp.config("html", {
                capabilities = default_capabilities,
            })

            vim.lsp.enable("html")
        end

        if mason_registry.is_installed("vtsls") then
            vim.lsp.config("vtsls", {
                capabilities = default_capabilities,
            })

            vim.lsp.enable("vtsls")
        end

        if mason_registry.is_installed("ltex_plus") then
            vim.lsp.config("ltex_plus", {
                capabilities = default_capabilities,
                filetypes = {
                    -- "bib",
                    -- "context",
                    "gitcommit",
                    "html",
                    "markdown",
                    "org",
                    "pandoc",
                    -- "plaintex",
                    -- "quarto",
                    "mail",
                    "mdx",
                    -- "rmd",
                    -- "rnoweb",
                    -- "rst",
                    -- "tex",
                    -- "text",
                    -- "typst",
                    "xhtml",
                },
                settings = {
                    ltex = {
                        language = "en-US",
                    },
                },
            })
            vim.lsp.enable("ltex_plus")
        end

        if mason_registry.is_installed("gdtoolkit") then
            vim.lsp.config("gdscript", {
                --force_setup = true, -- because the LSP is global. Read more on lsp-zero docs about this.
                capabilities = default_capabilities,
            })

            vim.lsp.enable("gdscript")
        end

        local util = require("lspconfig.util")

        if mason_registry.is_installed("css-lsp") then
            vim.lsp.config("cssls", {
                capabilities = default_capabilities,
                default_config = {
                    cmd = { "vscode-css-language-server", "--stdio" },
                    filetypes = { "css", "scss", "less" },
                    init_options = { provideFormatter = true }, -- needed to enable formatting capabilities
                    root_dir = util.root_pattern("package.json", ".git"),
                    single_file_support = true,
                    settings = {
                        css = { validate = true },
                        scss = { validate = true },
                        less = { validate = true },
                    },
                },
            })

            vim.lsp.enable("cssls")
        end

        if mason_registry.is_installed("json-lsp") then
            vim.lsp.config("jsonls", {
                capabilities = default_capabilities,
            })

            vim.lsp.enable("jsonls")
        end

        if mason_registry.is_installed("lua-language-server") then
            vim.lsp.config("lua_ls", {
                capabilities = default_capabilities,
                on_init = function(client)
                    if client.workspace_folders then
                        local path = client.workspace_folders[1].name
                        if vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc") then
                            return
                        end
                    end

                    -- lua ls returns two definitions on vim.lsp.buf.definition()
                    -- in order to fix this, use the following code.
                    -- when the ticket https://github.com/LuaLS/lua-language-server/issues/2451
                    -- will be resolved, you can delete the code.
                    local locations_to_items = vim.lsp.util.locations_to_items
                    vim.lsp.util.locations_to_items = function(locations, offset_encoding)
                        local lines = {}
                        local loc_i = 1
                        for _, loc in ipairs(vim.deepcopy(locations)) do
                            local uri = loc.uri or loc.targetUri
                            local range = loc.range or loc.targetSelectionRange
                            if lines[uri .. range.start.line] then -- already have a location on this line
                                table.remove(locations, loc_i) -- remove from the original list
                            else
                                loc_i = loc_i + 1
                            end
                            lines[uri .. range.start.line] = true
                        end

                        return locations_to_items(locations, offset_encoding)
                    end

                    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
                        runtime = {
                            -- Tell the language server which version of Lua you're using
                            -- (most likely LuaJIT in the case of Neovim)
                            version = "LuaJIT",
                        },
                        -- Make the server aware of Neovim runtime files
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                vim.env.VIMRUNTIME .. "lua",
                                "~/.local/share/nvim/luv/lib",
                            },
                        },
                    })
                end,
                settings = {
                    Lua = {
                        diagnostics = {
                            disable = { "incomplete-signature-doc", "missing-fields" },
                            -- You could add more globals i.e., "vim" here, albeit w/o intellisense
                            globals = { "vim", "MiniMap" },
                        },
                    },
                },
            })

            vim.lsp.enable("lua_ls")
        end
    end,
}

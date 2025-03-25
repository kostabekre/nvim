return {
    'nicholasmata/nvim-dap-cs',
    dependencies = { 'mfussenegger/nvim-dap' } ,
    config = function ()
        local mason_registry = require("mason-registry")
        local netcoredbg = mason_registry.get_package("netcoredbg") -- note that this will error if you provide a non-existent package name
        local path = netcoredbg:get_install_path() -- returns a string like "/home/user/.local/share/nvim/mason/packages/netcoredbg"

        require('dap-cs').setup{
            netcorebg = {
                path = path
            }
        }
    end
}

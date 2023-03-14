local dap = require('dap')

vim.keymap.set('n', '<F5>', dap.continue, {})
vim.keymap.set('n', '<F10>',dap.step_over, {})
vim.keymap.set('n', '<F11>',dap.step_into, {})
vim.keymap.set('n', '<F12>',dap.step_out, {})
vim.keymap.set('n', '<Leader>b',dap.toggle_breakpoint, {})
-- vim.keymap.set('n', '<Leader>B',dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
-- vim.keymap.set('n', '<Leader>lp',dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
vim.keymap.set('n', '<Leader>dr',dap.repl.open, {})
vim.keymap.set('n', '<Leader>dl',dap.run_last, {})

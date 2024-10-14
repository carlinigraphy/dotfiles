local opt_local = vim.opt_local
local api       = vim.api

opt_local.shiftwidth  = 2
opt_local.tabstop     = 2
opt_local.softtabstop = 2
opt_local.textwidth   = 80

vim.keymap.set('n', '<leader>m', function ()
   local cmd = ':term chez --debug-on-exception --script ' .. vim.fn.expand('%:p')
   api.nvim_command(':w')
   api.nvim_command(':tabnew')
   api.nvim_command(':setlocal nonumber norelativenumber')
   api.nvim_command(cmd)
   api.nvim_buf_set_name(0, 'chez')
   api.nvim_command('')
   api.nvim_input('a')
end)

--[[
Pretty quick n' dirty. Can clean this up later.

For now it's good enough to...
   - fire up IEx
   - send the current line, or visual selection, to the IEx terminal
   - recompile on save, or manually

--]]


local nvim_command = vim.api.nvim_command
local nvim_input   = vim.api.nvim_input


vim.keymap.set('n', '<leader>m', function ()
   nvim_command(':w | tabnew')
   nvim_command(':setlocal nonumber norelativenumber')
   nvim_command(':term iex -S mix')
   vim.api.nvim_buf_set_name(0, 'iex') 
end)


vim.keymap.set('n', ',r', function ()
   nvim_command(':w')

   local channel
   for _, ch in pairs(vim.api.nvim_list_chans()) do
      -- sets channel to `id' of first channel w/ pty
      channel = channel or (ch['pty'] and ch['id'])
   end

   vim.api.nvim_chan_send(channel, ' ' .. 'recompile\n')
   nvim_command('tabnext')
end)


vim.keymap.set('v', ',d', function ()
   nvim_command('norm "0y')

   local channel
   for _, ch in pairs(vim.api.nvim_list_chans()) do
      -- sets channel to `id' of first channel w/ pty
      channel = channel or (ch['pty'] and ch['id'])
   end

   vim.api.nvim_chan_send(channel, ' ' .. vim.fn.getreg(0))
   nvim_command('tabnext')
   nvim_input('A')
end)


vim.keymap.set('n', ',d', function ()
   local channel
   for _, ch in pairs(vim.api.nvim_list_chans()) do
      -- sets channel to `id' of first channel w/ pty
      channel = channel or (ch['pty'] and ch['id'])
   end

   vim.api.nvim_chan_send(channel, ' ' .. vim.api.nvim_get_current_line())
   nvim_command('tabnext')
   nvim_input('A')
end)

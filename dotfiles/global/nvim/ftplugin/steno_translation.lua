local bufopt  = vim.bo
local winopt  = vim.wo
local key_set = vim.keymap.set

vim.wo.spell       = true
vim.wo.scrollbind  = true
vim.wo.scrolloff   = -1
vim.bo.smartindent = false
vim.bo.autoindent  = false
vim.bo.textwidth   = 72

key_set('i', '<C-e>', '<C-o>5<C-e>', {buffer=true})
key_set('i', '<C-y>', '<C-o>5<C-y>', {buffer=true})

key_set('i', ':re', 'REVIEW::', {buffer=true})
key_set('i', ':er', 'ERROR::', {buffer=true})
key_set('n', '<leader>fe', function()
   vim.cmd.vimgrep('/\v(ERROR\\|REVIEW)::/ %')
end, {buffer=true})

key_set('i', ':hr', function()
   local rv = {}
   for _=1, vim.bo.textwidth do
      table.insert(rv, "─")
   end
   return table.concat(rv, "")
end, {
   buffer = true,
   expr = true
})

-- Little convoluted. If mid-way through typing a word, puts the
-- box-drawing character at the start of the line, and bumps the word to
-- the subsequent line, positioning the cursor back at EOL.
--key_set('i', 'jk', '<C-o>I│<CR><C-o>A', {buffer=true})
--key_set('i', 'kj', '<C-o>I┐<CR><C-o>A', {buffer=true})

local function mark_and_return(fn)
   local cursor = vim.api.nvim_win_get_cursor(0)
   local cursor_row    = cursor[1] - 1
   local cursor_column = cursor[2]

   local ns = vim.api.nvim_create_namespace('__')
   local id = vim.api.nvim_buf_set_extmark(0, ns, cursor_row, cursor_column, {})

   fn(cursor_row, cursor_column)

   local mark = vim.api.nvim_buf_get_extmark_by_id(0, ns, id, {})
   vim.api.nvim_win_set_cursor(0, {
      mark[1] + 1,
      mark[2]
   })
end

key_set('i', 'kj', function()
   mark_and_return(function(row, _)
      local last_line = vim.api.nvim_buf_get_lines(0, row-1, row, true)
      if (last_line[1] == '│') or (last_line[1] == '┐') then
         vim.cmd(':norm O│')
      else
         vim.cmd(':norm O┐')
      end
   end)
end, {buffer=true})

-- Spellcheck.
-- Uses extmarks to more accurately return to the original cursor
-- position. Even if the line was shifted by the `1z=` correction.
key_set('i', '<C-h>', function()
   mark_and_return(function(_, _)
      vim.cmd(':norm [s')  --< previous misspelling
      vim.cmd(':norm 1z=') --< accept 1st suggestion
   end)
end, {buffer=true})



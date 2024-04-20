--[[  notes.

Refs:
 `vim.o`  behaves like `:set`
 `vim.go` behaves like `:setglobal`
 `vim.bo` behaves like `:setlocal` for buffer-local options
 `vim.wo` behaves like `:setlocal` for window-local options

`vim.api.nvim_set_keymap`  can be used for more fine grained control over
setting keymaps.
`vim.keymap.set`  makes things easier, by allowing a function in the `rhs`,
and always setting `noremap`. It is equivalent to:
 vim.api.nvim_set_keymap(mode, lhs, rhs, {noremap=true})
ref. https://neovim.io/news/2022/04
ref. :h vim.keymap.set

THINKIES: couple keys aren't used for very much, and are good candidates for
buffer-local bindings.
   _ :: equiv. to `^'
   | :: equiv to `0'
   \ :: noop
   s :: equiv to cl
   S :: equiv to CC, I never use this

`s' is an interesting prefix. It's on the left side of the keyboard, on the
home row. Makes it perfect to bind to keys that operate on hjkl motions. E.g.,
sh, sj, sk, sl.

`|' and `\' make more sense as infrequently pressed keys. Perhaps a toggle?
Maybe can be for toggling a terminal.

`_' also good candidate for a toggle-able something semi-frequent.
--]]
vim.g.mapleader = ' '

local set = vim.keymap.set

set('n', '<leader>t',  ':sp | :term<CR>a')
set('t', '<C-w>',      '<C-\\><C-n><C-w>')

set('n', 'U', '<C-r>')
set('n', 'Y', 'y$')
set('i',  '<C-l>', '<C-x><C-l>')

set('n', '<leader>xa', ':wa | qa!<CR>')

set('n', '<leader>y', '"+y')
set('v', '<leader>y', '"+y')

set('n', '<leader>sp', ':set spell!<CR>')
set('n', '<leader>z', '1z=')

set('v', '<leader>col', '! column -L -t -s= -o=<CR>')

set('n', '-', '5<C-w><')
set('n', '+', '5<C-w>>')
set('n', '=', '<C-w>=')

set('n', '<C-e>', '3<C-e>')
set('n', '<C-y>', '3<C-y>')

set('n', '<leader>b', ':ls<CR>:b<Space>')
set('n', '<leader>n', ':bnext<CR>')

set('n', '[d', vim.diagnostic.goto_prev)
set('n', ']d', vim.diagnostic.goto_next)


--[[ NOT YET SUPPORTED.
-- Supposedly this was merged into nvim:master, but apparently hasn't hit arch
-- repos yet. Will allow for setting command/insert abbreviations w/ `ca' and
-- `ci', and have a rhs function. Drastically better than vimscript, which I do
-- not believe supports functions in abbreviations.
--
set('ca', 'vres', 'vert res')
--]]

--[[  THINKIES:

Couple keys aren't used for very much, and are good candidates for buffer-local
bindings.
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

local set = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Terminal.
set('n', '<leader>t',  ':sp | :term<CR>a')
set('t', '<C-w>',      '<C-\\><C-n><C-w>')

-- Spelling.
set('n', '<leader>sp', ':set spell! | set spell?<CR>')
set('n', '<leader>sf', '1z=') -- mnemonic: [s]pell [f]ix

set('n', 'U', '<C-r>')
set({'n', 'v', 'x'}, '<leader>y', '"+y')
set('v', '<leader>col', '! column -L -t -s= -o=<CR>')
--^ TODO; this should probably just be a function.

set('n', '<C-e>', '3<C-e>')
set('n', '<C-y>', '3<C-y>')

set("n", "n", "nzzzv", { desc="Next search (center view)" })
set("n", "N", "Nzzzv", { desc="Prev search (center view)" })
set("n", "<C-d>", "<C-d>zz", { desc="Half-page down (center view)" })
set("n", "<C-u>", "<C-u>zz", { desc="Half-page up (center view)" })

set("v", ">", ">gv", { desc="Indent, maintain visual mode" })
set("v", "<", "<gv", { desc="Indent, maintain visual mode" })

set('n', '<leader>n', ':bnext<CR>')
set('n', '<leader>b', ':ls<CR>:b<SPACE>')

-- Would love to have bindings to open in a split, but `:vs <cfile>` doesn't
-- take the line number into account.
set('n', 'gf', 'gF')

set("n", "<leader>v", ":vert res 87")

-- The only option that's allowed here, because it's pretty much a binding.
set('c', '<C-b>', '<Left>')  -- OVERWRITES: cursor to beginning of line
set('c', '<C-f>', '<Right>') -- OVERWRITES: `cedit` key (below)
vim.o.cedit = '<C-o>'

-- Make more consistent with how I have my vi bindings set up.
set("c", "<C-n>", "<Down>")
set("c", "<C-p>", "<Up>")

set("n", "<leader>fu", function()   -- mnemonic  [fu]zzy
   local is_set
   for _,k in ipairs(vim.opt.wildoptions:get()) do
      if k == "fuzzy" then
         is_set = true
      end
   end

   if is_set then
      vim.opt.wildoptions:remove("fuzzy")
   else
      vim.opt.wildoptions:append("fuzzy")
   end

   vim.cmd("set wildoptions") -- print current opts
end)

--                                 trial run
--------------------------------------------------------------------------------
-- 2024-06-30
--    Created.
-- 2024-10-29
--    Changed from J/K to <C-n>, <C-p>. Didn't like that it overwrote [J]oin.
set('v', '<C-p>', [[:move '<-2'<CR>gv=gv]])
set('v', '<C-n>', [[:move '>+1'<CR>gv=gv]])

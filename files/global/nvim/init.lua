require('bindings')
require('options')

vim.opt.rtp:prepend(
   vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
)

require('lazy').setup('plugins', {
   root             = vim.fn.stdpath('data')   .. '/lazy/',
   lockfile         = vim.fn.stdpath('config') .. '/lazy-locks/lazy-lock.json',
   change_detection = {
      notify  = false,
   },
   ui = {
      border = {
         "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏",
      },
      backdrop = 100,
   },
   diff = { cmd = 'git' },
})

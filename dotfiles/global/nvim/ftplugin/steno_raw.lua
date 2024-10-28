vim.wo.tw          =60
vim.wo.scrollbind  = true
vim.bo.smartindent = false
vim.bo.autoindent  = false

vim.opt.listchars:append({space = '─'})
vim.api.nvim_set_hl(0, 'NonText', { guifg='#202020' })

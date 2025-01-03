vim.keymap.set('ia', 'vins', function()
   vim.snippet.expand('vim.inspect($0)')
end, { buffer=true })

vim.keymap.set('ia', 'pvins', function()
   vim.snippet.expand('print(vim.inspect($0))')
end, { buffer=true })

vim.keymap.set('ia', 'sfmt', function()
   vim.snippet.expand('print(("$1"):format($0))')
end, { buffer=true })

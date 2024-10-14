local set = vim.keymap.set

set('ia', 'hr1', function()
   local width = vim.bo.textwidth
   if width == 0 then width = 80 end
   return string.rep('=', 80)
end, {expr=true})

set('ia', 'hr2', function()
   local width = vim.bo.textwidth
   if width == 0 then width = 80 end
   return string.rep('-', width)
end, {expr=true})

set('ia', 'hr3', function()
   local width = vim.bo.textwidth
   if width == 0 then width = 80 end
   width = (width/2) - 1
   return '-' .. string.rep(' -', width)
end, {expr=true})

--vim.wo.concealcursor = 'n'
vim.wo.conceallevel = 2

vim.bo.keywordprg = ":Thoughts tag"
vim.opt.iskeyword:append({ "-" })

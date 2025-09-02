vim.g.termdebug_config = {
   -- wide = 163,
   variables_window = 1,
   variables_window_height = 10,
}

vim.opt_local.makeprg = "tup"
vim.opt_local.textwidth = 80

-- I spent too long trying to troubleshoot & debug some stupid autocmd. It
-- wasn't actually loading under the right conditions, wasn't executing at all,
-- etc.. Sometimes the most idiot simple solution is the best I guess.
vim.cmd("silent! packadd termdebug")

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
   pattern = "*.c",
   callback = function()
      vim.cmd [[:silent! !rg --files | rg '\.c$' | xargs ctags && global -u]]
   end,
})

vim.keymap.set("n", "]d", ":cn<CR>"  , { buffer=true })
vim.keymap.set("n", "[d", ":cp<CR>"  , { buffer=true })
vim.keymap.set("ia", "#i", "#include", { buffer=true })

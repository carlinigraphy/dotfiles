return {
   {  "https://git.sr.ht/~carlinigraphy/beancount.nvim" },
   {  "https://git.sr.ht/~carlinigraphy/steno.nvim",    },
   {  "https://git.sr.ht/~carlinigraphy/dictd.nvim",
      config = function()
         require("dictd").configure({
            keymap = '<leader>df',
            filetypes = { 'text', 'steno_translation', 'markdown' }
         })
      end,
   },

   { "tpope/vim-fugitive" },
   { "tpope/vim-vinegar"  },
}

return {
   { "thoughts.nvim",
      dir = "~/hg/nvim_plugins/thoughts.nvim",
   },
   { "buffy.nvim",
      enabled = true,
      dir = "~/hg/nvim_plugins/buffy.nvim",
   },
   {
      "https://git.sr.ht/~carlinigraphy/steno.nvim"
   },
   {
      "https://git.sr.ht/~carlinigraphy/dictd.nvim",
      config = function()
         require("dictd").configure({
            keymap = '<leader>df',
            filetypes = { 'text', 'steno_translation', 'markdown' }
         })
      end,
   },
   { "tpope/vim-vinegar" },
   {
      "isovector/cornelis",
      dependencies = {
         "kana/vim-textobj-user",
         "neovimhaskell/nvim-hs.vim",
      },
      ft      = "agda",
      version = "v2.7.*",
      build   = "stack install",
      config  = require("plugins.config.cornelis")
   },
}

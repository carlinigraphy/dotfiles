return {
   { 'williamboman/mason.nvim',
      cmd  = 'Mason',
      opts = {
         ui = {
            border = "shadow",
            height = 0.8,
            width  = 0.5,
         },
      },
   },
   { 'neovim/nvim-lspconfig',
      dependencies = {
         'williamboman/mason.nvim',
         'williamboman/mason-lspconfig.nvim',
      },
      event = { "BufReadPre", "BufNewFile" },
   },
}

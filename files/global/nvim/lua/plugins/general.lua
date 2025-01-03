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

   {  "stevearc/oil.nvim",
      enabled = true,
      cmd = "Oil",
      opts = {
         silence_scp_warning = true,
         keymaps = {
            -- It may actually be useful to maintain default `q', especially to
            -- bulk rename files/dirs.
            ["q"]  = "actions.close",
            ["K"]  = "actions.preview",
            ["gh"] = "actions.toggle_hidden", -- same as netrw
            ["gs"] = "actions.select_split",
            ["gv"] = "actions.select_vsplit",
         },
         columns = {
            { "permissions", highlight = "Comment" },
         },
         win_options = {
            fillchars = (vim.wo.fillchars .. ",eob: ")
         },
         float = {
            max_width  = 50,
            max_height = 20,
         },
      },
      config = function(_, opts)
         require("oil").setup(opts)
      end
   },

   { "tpope/vim-fugitive" },
}

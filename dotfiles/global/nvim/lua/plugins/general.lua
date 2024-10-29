return {
   {  "carlinigraphy/dictd.nvim",
      --dir = "/home/aurelius/hg/nvim_plugins/dictd.nvim",
      config = function()
         require("dictd").setup({
            key = '<leader>df',
            keywordprg_filetypes = {
               'text', 'steno_translation'
            }
         })
      end,
   },

   {  "carlinigraphy/steno.nvim",
      --dir = "/home/aurelius/hg/nvim_plugins/steno.nvim",
      config = function()
         require("steno").setup()
      end,
   },

   {  "carlinigraphy/elixir-repl.nvim",
      enabled = true,
      ft = "elixir",
      config = function()
         require("elixir-repl").setup()
      end
   },

   {  "sindrets/diffview.nvim",
      enabled = false,
      opts = {
         hg_cmd = { "chg" },
         use_icons = false,
      },
      cmd = {
         'DiffviewOpen',
         'DiffviewFileHistory',
      },
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

   --[[ NOTES;
   -- Too heavy. Features much too specific to telekasten itself. Not enough
   -- general vim feel to it. Been looking a lot more recently for plugins that
   -- don't feel like learning that plugin itself, but it's just a natural
   -- extension of my normal vim editing experience. Good stuff to potentially
   -- take from here as a reference though.
   --
   {  "nvim-telekasten/telekasten.nvim",
      enabled = true,
      dependencies = {
         "nvim-lua/plenary.nvim",
         "nvim-telescope/telescope.nvim"
      },
      opts = {
         home = vim.fn.expand("~/wiki/telekasten/")
      }
   },
   --]]

   --[[ NOTES;
   -- I like the **idea** and **approach** of this plugin more than I like the
   -- plugin itself. Definitely a lot of great ideas to try and steal.
   --    - Utilizing native vim functionality through taglists, completion, etc.
   --    - Simple, minimal approach, not a lot of unique commands
   --    - Preview window
   --
   {  "Furkanzmc/zettelkasten.nvim",
      enabled = true,
      opts = {
         notes_path = vim.fn.expand("~/wiki/zettelkasten.nvim/")
      },
   },
   --]]
}

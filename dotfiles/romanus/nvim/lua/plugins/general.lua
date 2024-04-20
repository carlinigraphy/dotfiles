return {
   {  "carlinigraphy/elixir-repl.nvim",
      ft = "elixir",
      config = function()
         require("elixir-repl").setup()
      end
   },

   {  "sindrets/diffview.nvim",
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
      opts = {
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
   },
}

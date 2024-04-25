return {
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
}

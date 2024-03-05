return {
   {  "ThenWhenceComethEvil/elixir-repl.nvim",
      ft = "elixir",
      config = function (opts)
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
}

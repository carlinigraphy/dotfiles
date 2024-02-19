return {
   {  "ThenWhenceComethEvil/elixir-repl.nvim",
      ft = "elixir",
      config = function (opts)
         require("elixir-repl").setup()
      end
   },

   --[[
   -- This plugin is excellent, and I do think it's something worth putting the
   -- time into configuring and learning. But it does seem to work a *little*
   -- less well for mercurial. As everything seems to. Sigh.
   {  "sindrets/diffview.nvim",
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      opts = {
         hg_cmd = { "chg" },
      },
   },
   --]]
}

return {
   --[==[
   {  -- This plugin is very cool, but somehow gets in the way. The `auto_close`
      -- config options seem to not work, and signature help is still shown
      -- well after closing the `)'.
      --
      -- 2024-03-24 ::
      -- Think I'l try this for a bit, see how I feel about it after some use.
      -- I'm hoping that using only hint text will make it less obtrusive.
      --
      -- 2024-03-26 ::
      -- Oof, it just gives not good hints too often. The delay and jumpiness
      -- is noticeable.
      "ray-x/lsp_signature.nvim",
      config = function()
         require'lsp_signature'.setup({
            padding = '',
            floating_window = false,
            hint_enable = true,
            hint_prefix = '',
            doc_lines = 0,
         })
      end,
   },
   --]==]

   --[==[
   -- 2024-03-23 ::
   -- Some problems I'm having with snippets now:
   --
   --    1) Text suggestions are kinda fucky. In a file with "TSNode" like 400
   --       times, I need to type `TSNo-` before it's suggested as an option.
   --
   --    2) While completions are very fast, they're not fast enough. There is
   --       a noticable delay when compared to using native <C-p> / <C-n>
   --       completion.

   { 'hrsh7th/nvim-cmp',
      dependencies = {
         { 'hrsh7th/cmp-buffer'   },
         { 'hrsh7th/cmp-nvim-lsp' },
         { 'hrsh7th/cmp-nvim-lsp-signature-help' },

         { 'L3MON4D3/LuaSnip', opts = true },
         { 'saadparwaiz1/cmp_luasnip' },
      },
      config = function()
         local cmp = require("cmp")
         cmp.setup({
            sources = cmp.config.sources({
               { name = "luasnip"                 },
               { name = "nvim_lsp"                },
               { name = "nvim_lsp_signature_help" },
            }, {
               { name = "buffer" },
            }),
            snippet = {
               expand = function( args)
                  --vim.snippet.expand(args.body) --[[ Requires nvim 0.10+ ]]
                  require('luasnip').lsp_expand(args.body)
               end,
            },
            mapping = cmp.mapping.preset.insert({
               ['<C-b>']     = cmp.mapping.scroll_docs(-4),
               ['<C-f>']     = cmp.mapping.scroll_docs(4),
               ['<C-Space>'] = cmp.mapping.complete(),
               ['<C-e>']     = cmp.mapping.abort(),
               ['<CR>']      = cmp.mapping.confirm({ select = true }),
            }),
         })
      end
   },
   --]==]


   --[==[
   -- 2024-03-23 ::
   -- Comparing nvim-cmp with coq.
   --
   -- Oddly enough I don't have the '^@' problems with LuaLS when using coq.
   -- The mystery deepens. I don't love the configuration, or initialization for
   -- coq though. Doesn't feel idiomatic for nvim plugins.
   --
   -- Also I think I fundamentally just don't like shit popping up all over my
   -- screen while I'm trying to work. Manually triggered completion is
   -- certainly the way to go. Maybe writing my own extremely simple version
   -- is a future project.
   --
   { "ms-jpq/coq_nvim",
      ref = "coq",
      dependencies = {
         { "ms-jpq/coq.artifacts", ref = "artifacts" },
      },
      build = ":COQdeps",
      config = function()
         vim.cmd[[ COQnow --shut-up ]]
      end,
   },
   --]==]
}

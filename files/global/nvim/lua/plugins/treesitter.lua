-- vim: nowrap

return {
   { 'nvim-treesitter/nvim-treesitter-context',
      opts = {
         enable              = true,
         max_lines           = 3,          -- How many lines the window should span. Values <= 0 mean no limit.
         min_window_height   = 0,          -- Minimum editor window height to enable context. Values <= 0 mean no limit.
         line_numbers        = true,
         multiline_threshold = 20,         -- Maximum number of lines to collapse for a single context line
         trim_scope          = 'outer',    -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
         mode                = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
      }
   },

   { 'nvim-treesitter/nvim-treesitter',
      build  = ':TSUpdate',
      config = function(_, opts)
         require('nvim-treesitter.configs').setup(opts)

         local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
         parser_config.thoughts = {
            install_info = {
               url = vim.fn.expand("~/hg/nvim_plugins/tree-sitter-thoughts/"),
               files = { "src/parser.c" },
               generate_reqires_npm = false,
               requires_generate_from_grammar = false,
            },
            filetype = "thoughts",
         }
      end,
      opts = {
         ensure_installed = {
            "bash",
            "beancount",
            "elixir",
            "lua",
            "scheme",
            "toml",
            "yaml",
         },
         highlight = {
            enable = true,
         },
      },
   },
}

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
      --dependencies = { 'nvim-treesitter/nvim-treesitter-refactor' },
      build  = ':TSUpdate',
      config = function(_, opts)
         require('nvim-treesitter.configs').setup(opts)
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
         --[[
         -- This is interesting, but I just didn't end up using it. To make
         -- more usable, should also set the hl group TSDefinitionUsage, and
         -- 'updatetime=0'. Though the updatetime would impact anything else
         -- subscribing to the CursorHold event.
         refactor = {
            highlight_definitions = {
               enable = true,
               clear_on_cursor_move = true,
            },
         }
         --]]
      },
   },
}

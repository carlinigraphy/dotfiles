-- vim: nowrap

--[[ TODO

Couple things that are still bothering me here. The `list_definitions_toc`
seems to not work. I know it used to. Worth digging into why at some point.

https://github.com/nvim-treesitter/nvim-treesitter-refactor/blob/master/lua/nvim-treesitter-refactor/navigation.lua#L96

--]]

return {
   { 'nvim-treesitter/playground',
      cmd = 'TSPlaygroundToggle',
   },
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
      dependencies = {
         { 'nvim-treesitter/nvim-treesitter-refactor',
            keys = { 'gnd', 'gO' } ,
         },
      },
      config = function(_, opts)
         require('nvim-treesitter.configs').setup(opts)
      end,
      opts = {
         ensure_installed = {
            "scheme",
            "bash",
            "lua",
            "erlang",
            "elixir",
            "python",
            "toml",
         },
         highlight = {
            enable = true,
         },
         refactor = {
            navigation = {
               enable  = true,
               keymaps = {
                  goto_definition      = 'gnd',
                  list_definitions_toc = 'gO',
               },
            },
         },
      },
   },
}

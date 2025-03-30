return {
   {  "carlinigraphy/scm-edit.nvim",
      --dir = "/home/aurelius/hg/nvim_plugins/scm-edit.nvim/",
      ft = { "scheme" },
      config = true,
   },

   { "Olical/conjure",
      ft = { "scheme", "racket", "fennel", "lua" },
      config = function ()
         vim.g["conjure#log#hud#enabled"] = false
         vim.g["conjure#completion#omnifunc"] = false

         vim.g["conjure#client#scheme#stdio#command"]              = "chez"
         vim.g["conjure#client#scheme#stdio#prompt_pattern"]       = "> $?"
         vim.g["conjure#client#scheme#stdio#value_prefix_pattern"] = false

         vim.g["conjure#filetype#fennel"] = "conjure.client.fennel.aniseed"

         -- Be more like slimv. I find the default options more verbose.
         vim.g["conjure#mapping#prefix"]           = ","
         vim.g["conjure#mapping#eval_root_form"]   = "d"
         vim.g["conjure#mapping#eval_marked_form"] = "m"
         vim.g["conjure#mapping#log_toggle"]       = "t"
         vim.g["conjure#mapping#eval_buf"]         = "b"
         vim.g["conjure#mapping#eval_file"]        = "f"
         vim.g["conjure#mapping#eval_visual"]      = "r"

         -- colors.
         vim.g["conjure#highlight#enabled*"]    = true
         vim.g["conjure#eval#inline#highlight"] = "Type"

         -- disable mappings.
         vim.g["conjure#mapping#doc_word"] = false  -- not supported
      end,
   },

   -- { "gpanders/nvim-parinfer",
   --    ft = { "scheme", "racket", "fennel" },
   -- },

   { "ekaitz-zarraga/nvim-paredit-scheme",
      ft = "scheme",
      pin = true,
      dependencies = {
         "julienvincent/nvim-paredit"
      },
      config = function ()
         local paredit = require("nvim-paredit")
         local paredit_scheme = require("nvim-paredit-scheme")
         paredit_scheme.setup(paredit)
      end,
   },

   { "julienvincent/nvim-paredit",
      ft  = { "scheme", "racket", "fennel" },
      pin = true,

      config = function ()
         local paredit = require("nvim-paredit")

         -- <Nop> normal-mode defaults.
         vim.api.nvim_buf_set_keymap(0, "n", "s", "", {nowait=true})
         vim.api.nvim_buf_set_keymap(0, "n", "S", "", {nowait=true})

         local function wrap_form(left, right)
            return function ()
               paredit.cursor.place_cursor(
                  paredit.wrap.wrap_enclosing_form_under_cursor(left, right), {
                     placement = "inner_end",
                     mode = "insert"
                  }
               )
            end
         end

         local function wrap_element(left, right)
            return function ()
               paredit.cursor.place_cursor(
                  paredit.wrap.wrap_element_under_cursor(left, right), {
                     placement = "inner_end",
                     mode = "insert"
                  }
               )
            end
         end

         paredit.setup({
            use_default_keys = false,
            keys = {
               ['su'] = { paredit.unwrap.unwrap_form_under_cursor, 'Splice sexp' },

               ['))'] = { paredit.api.slurp_forwards  , 'Slurp forwards'  , mode = {'n'} },
               ['()'] = { paredit.api.barf_backwards  , 'Barf backwards'  , mode = {'n'} },
               ['(('] = { paredit.api.slurp_backwards , 'Slurp backwards' , mode = {'n'} },
               [')('] = { paredit.api.barf_forwards   , 'Barf forwards'   , mode = {'n'} },

               ['sh']  = { paredit.api.drag_element_backwards , 'Drag element left'  },
               ['sfh'] = { paredit.api.drag_form_backwards    , 'Drag form left'     },
               ['sl']  = { paredit.api.drag_element_forwards  , 'Drag element right' },
               ['sfl'] = { paredit.api.drag_form_forwards     , 'Drag form right'    },

               ['sr']  = { paredit.api.raise_element , 'Raise element' },
               ['sfr'] = { paredit.api.raise_form    , 'Raise form'    },

               ['s9']  = { wrap_element('(', ')') , 'Wrap element insert tail' },
               ['sf9'] = { wrap_form('(', ')')    , 'Wrap form insert tail'    },

               ['s[']  = { wrap_element('[', ']') , 'Wrap element insert tail' },
               ['sf['] = { wrap_form('[', ']')    , 'Wrap form insert tail'    },

               -- Using defaults.
               ["af"] = {
                  paredit.api.select_around_form,
                  "Around form",
                  repeatable = false,
                  mode = { "o", "v" }
               },
               ["if"] = {
                  paredit.api.select_in_form,
                  "In form",
                  repeatable = false,
                  mode = { "o", "v" }
               },
               ["ae"] = {
                  paredit.api.select_element,
                  "Around element",
                  repeatable = false,
                  mode = { "o", "v" },
               },
               ["ie"] = {
                  paredit.api.select_element,
                  "Element",
                  repeatable = false,
                  mode = { "o", "v" },
               },

            },
         })
      end,
   }
}

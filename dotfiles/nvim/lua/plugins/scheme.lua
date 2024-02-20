return {
   { 'Olical/conjure',
      ft = { 'scheme' },
      config = function (_, opts)
         vim.g['conjure#log#hud#enabled'] = false

         vim.g['conjure#client#scheme#stdio#command']              = 'chez'
         vim.g['conjure#client#scheme#stdio#prompt_pattern']       = '> $?'
         vim.g['conjure#client#scheme#stdio#value_prefix_pattern'] = false

         -- Be more like slimv. I find the default options more verbose.
         vim.g['conjure#mapping#prefix']           = ','
         vim.g['conjure#mapping#eval_root_form']   = 'd'
         vim.g['conjure#mapping#eval_marked_form'] = 'm'
         vim.g['conjure#mapping#log_toggle']       = 't'
         vim.g['conjure#mapping#eval_buf']         = 'b'
         vim.g['conjure#mapping#eval_file']        = 'f'
         vim.g['conjure#mapping#eval_visual']      = 'r'

         -- colors.
         vim.g['conjure#highlight#enabled*']    = true
         vim.g['conjure#eval#inline#highlight'] = 'Type'

         -- disable mappings.
         vim.g['conjure#mapping#doc_word'] = false  -- not supported
      end,
   },

   { 'ekaitz-zarraga/nvim-paredit-scheme',
      ft = { 'scheme' },
      pin = true,
      dependencies = { 'julienvincent/nvim-paredit' },
      config = function ()
         local paredit = require('nvim-paredit')
         local paredit_scheme = require('nvim-paredit-scheme')
         paredit_scheme.setup(paredit)
      end,
   },

   { 'julienvincent/nvim-paredit',
      ft = { 'scheme' },
      pin = true,

      dependencies = {
         'windwp/nvim-autopairs',
      },

      config = function ()
         local paredit = require('nvim-paredit')

         --- Don't know if I want to use localleader. Keeping here for a bit in
         --- case.
         --vim.g.maplocalleader = ','

         -- <Nop> normal-mode defaults.
         vim.api.nvim_buf_set_keymap(0, 'n', 's', '', {nowait=true})
         vim.api.nvim_buf_set_keymap(0, 'n', 'S', '', {nowait=true})

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
            keys = {
               ['ss'] = { paredit.unwrap.unwrap_form_under_cursor, 'Splice sexp' },

               --[[
                  I think of these in terms of 'move the left paren to the
                  right', 'move the left paren to the left', etc.. It's a good
                  mental model for me. The only part I don't like is that it
                  removes the ability to use '(' and ')' to navigate the text.
                  Likewise, I could use '<<' to mean 'move left paren left'
                  instead of '((', but then I can't dedent lines in normal
                  mode.
               --]]
               ['))'] = { paredit.api.slurp_forwards , 'Slurp forwards' },
               ['()'] = { paredit.api.barf_backwards , 'Barf backwards' },

               ['(('] = { paredit.api.slurp_backwards , 'Slurp backwards' },
               [')('] = { paredit.api.barf_forwards   , 'Barf forwards'   },

               ['sh']  = { paredit.api.drag_element_backwards , 'Drag element left'  },
               ['sfh'] = { paredit.api.drag_form_backwards    , 'Drag form left'     },
               ['sl']  = { paredit.api.drag_element_forwards  , 'Drag element right' },
               ['sfl'] = { paredit.api.drag_form_forwards     , 'Drag form right'    },

               ['sr']  = { paredit.api.raise_element , 'Raise element' },
               ['sfr'] = { paredit.api.raise_form    , 'Raise form'    },

               -- Not 100% on these yet, I might want to keep the `sw` mapping
               -- for `wrap'. Though `sw' is a little annoying to type. Don't
               -- like two characters on the 3rd finger.
               ['s(']  = { wrap_element('(', ')') , 'Wrap element insert tail' },
               ['sf('] = { wrap_form('(', ')')    , 'Wrap form insert tail'    },

               ['s[']  = { wrap_element('[', ']') , 'Wrap element insert tail' },
               ['sf['] = { wrap_form('[', ']')    , 'Wrap form insert tail'    },
            },
         })
      end,
   }
}

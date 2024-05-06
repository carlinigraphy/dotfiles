-- vim: tw=80
-- payne's gray(scale)

--[[ TODO;

Still not 100% on background grayscale shades. Too much difference between them
for large UI windows, popups, etc.. It's necessary when trying to differentiate
two small boxes next to each other--but I don't know if I've run into that
situation.

Most common use cases have been
   - Mason, Lazy, etc., large UI windows,
   - documentation popups, and
   - the complete menu.

All of which are minimum 2x15. Should use that as a more accurate baseline for
future visibility tests.

--]]


--[[

Refinement of my old colorscheme(s).

   (1) Colors must aid in understanding of the text

       E.g., strings have a unique highlight. It is important to recognize
       strings apart from code. It is more important to recognize interpolation
       within a string.

       Syntax highlighting both visually cues where the string is, and isn't.

   (2) Color emphasis should mirror code importance.

       The eye is drawn to high contrast. A very bright white on a black
       background is more visually distinct than a mid-gray. Colors should 'pop'
       only when useful.

       Control flow is important to easily distinguish, thus it is useful to
       increase contrast. Comments can be pushed to the background, and require
       more intentionality to read.

   (3) Colors must mean something.

       For a token to be uniquely highlighted, there must be meaning to it's
       highlight group. Is there a reason one would highlight floats differently
       from ints. Or bools differently from strings. Maybe. Depends on language
       and function.

--]]

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'paynes-grayscale'

--- Special/accent colors ------------------------------------------------------
local yellow = '#eb9753'

local green  = {
   bg = '#1c3536',
   fg = '#5f8787',
}

local blue = {
   bg = {
      [ 0] = '#1c2836',
      [ 1] = '#2d4157',
   },
}

local red = {
   bg = {
      [ 0] = '#361C29',
      [ 1] = '#572d41',
   },
   fg = '#A7485A',
}

--- Regular colors -------------------------------------------------------------
local color = {
   bg = {
      [0] = '#161a1d',
      [1] = '#22262b',
      [2] = '#2d333a',
   },
   fg = {
      dim  = '#536878',
      norm = '#708090',
   },
}
local mono = {
   bg = {
      [-2] = '#000000',
      [-1] = '#0d0d0d',
      [ 0] = '#121212',
      [ 1] = '#181818',
      [ 2] = '#222222',
      [ 3] = '#282828',
   },
   fg = {
     comment = '#404040',
     dim     = '#707070',
     norm    = '#b0b0b0',
     emph    = '#f0f0f0',
   },
}

for _, tbl in ipairs({
   mono.bg, color.bg,
   mono.fg, color.fg,
}) do
   setmetatable(tbl, {
      __index = function (_, key)
         -- Second parameter is the hierarchy. `2' means one level up from this
         -- function. ref. https://www.lua.org/pil/8.5.html
         error("Invalid index: " .. key, 2)
      end
   })
end

--------------------------------------------------------------------------------
local fg = mono.fg.norm
local bg = mono.bg[0]

--------------------------------------------------------------------------------
local nvim_set_hl = vim.api.nvim_set_hl

for name, highlight in pairs({
   Normal = { fg = fg },

   --- Literals ----------------------------------------------------------------
   Boolean    = { fg = color.fg.norm, bold = true },
   String     = { fg = color.fg.dim   },
   Constant   = { link = 'Normal'     },
   Float      = { link = 'Normal'     },
   Number     = { link = 'Normal'     },
   Character  = { link = 'String'     },
   SpecialKey = { link = 'Special'    }, -- Lit. repr of ^V, ^C, etc.

   --- Language features, built-ins, etc. --------------------------------------
   Statement   = { link = 'Normal'      },
   Keyword     = { link = 'Normal'      },
   Special     = { link = 'Normal'      },
   Macro       = { link = 'Normal'      },
   Function    = { link = 'Normal'      },
   Identifier  = { fg = mono.fg.emph    },
   Conditional = { fg = mono.fg.emph    },
   Repeat      = { fg = mono.fg.emph    },
   Exception   = { fg = mono.fg.emph    },
   PreProc     = { fg = mono.fg.dim     },
   Define      = { fg = mono.fg.dim     },
   Operator    = { fg = mono.fg.dim     },
   Delimiter   = { fg = mono.fg.comment },
   Type        = { fg = color.fg.norm   },
   TypeDef     = { fg = color.fg.norm, bold = true },

   --- Text --------------------------------------------------------------------
   Comment    = { fg = mono.fg.comment },
   Conceal    = { link = 'Comment'     },
   NonText    = { link = 'Normal'      },
   Todo       = { fg = yellow          },
   DiffAdd    = { fg = fg           , bg = green.bg                },
   DiffChange = { fg = fg           , bg = blue.bg[0]              },
   DiffDelete = { fg = mono.bg[1]   , bg = bg                      },
   DiffText   = { fg = mono.fg.emph , bg = blue.bg[1], bold = true },
   SpellBad   = { fg = mono.fg.emph , bg = red.bg[0]               },
   SpellLocal = { fg = mono.fg.emph , bg = blue.bg[0]              },

   --- User interface ----------------------------------------------------------
   -- The color blue I picked for diff changed is the same as visual selection.
   -- I'm consider changing the selection color, but for now just doing this...
   Visual       = vim.o.diff and { reverse = true }
                              or { fg = mono.fg.emph, bg = blue.bg[0] },

   Pmenu        = { fg = mono.fg.comment, bg = mono.bg[-1] },
   PmenuSel     = { fg = fg, bg = mono.bg[-1]  },
   PmenuThumb   = { bg = mono.fg.dim },
   PmenuSbar    = { bg = mono.bg[1] },
   Folded       = { fg = mono.fg.comment, bg = mono.bg[1] },
   FoldColumn   = { fg = color.bg[2], bg = bg },
   Directory    = { fg = color.fg.norm, bold = true },
   Title        = { fg = mono.fg.emph, bold = true, underline = true },
   Question     = { link = 'Normal' },
   MoreMsg      = { link = 'Normal' },
   Error        = { link = 'SpellBad' },
   ErrorMsg     = { fg = red.fg },
   WarningMsg   = { fg = yellow },
   EndOfBuffer  = { link = 'LineNr' },
   ColorColumn  = { bg = mono.bg[1] },
   CursorLineNr = { fg = fg },
   LineNr       = { link = 'Comment' },
   Search       = { reverse = true },
   IncSearch    = { link = 'Search' },
   WinSeparator = { fg = mono.fg.comment },
   MatchParen   = { fg = fg, bg = blue.bg[1] },
   SignColumn   = { bg = bg },
   QuickFixLine = { link = 'Visual' },

   NormalInactive = { bg = bg },
   NormalFloat    = { bg = mono.bg[0] },
   FloatBorder    = { fg = color.bg[0], bg = mono.bg[0] },
   FloatShadow    = { bg = mono.bg[1] },
   FloatShadowThrough = { bg = bg, fg = fg },
   --^ The square cutouts not covered by the float shadow.

   -- TODO: To add from `:h highlight-groups` docs:
   --[[
      Substitute        `:s`  replacement text highlighting
      ModeMsg
      ModeArea
      MsgSeparator
   --]]

   -- My statusline groups.
   Statusline_Filetype     = { fg = fg, bg = bg },
   Statusline_Cursor       = { fg = mono.fg.emph, bg = mono.bg[1]  , bold = true },
   Statusline_Mode_Normal  = { fg = mono.fg.emph, bg = blue.bg[0]  , bold = true },
   Statusline_Mode_Insert  = { fg = mono.fg.emph, bg = green.bg    , bold = true },
   Statusline_Mode_Visual  = { fg = mono.fg.emph, bg = color.bg[0] , bold = true },
   Statusline_Mode_Replace = { fg = mono.fg.emph, bg = red.bg[0]   , bold = true },

   -- Built-in statusline groups, but should probably go with the above.
   StatusLineNC = { fg = mono.fg.dim, bg = mono.bg[1] },
   StatusLine   = { fg = fg, bg = mono.bg[1] },

   -- LSP groups.
   ['@field']       = { fg = fg },
   ['@variable']    = { fg = fg },
   ['@boolean']     = { link = 'Boolean'   },
   ['@bracket']     = { link = 'Delimiter' },
   ['@punctuation'] = { link = '@bracket'  },
   ['@constructor'] = { link = '@bracket'  },

   -- For some reason more nodes are disappearing from regular @conditional, and
   -- becomming @keyword.conditional. Iunno. Need to look more into this later.
   ['@keyword.function']    = { link = 'Operator'    },
   ['@keyword.operator']    = { link = 'Operator'    },
   ['@keyword.repeat']      = { link = 'Repeat'      },
   ['@keyword.conditional'] = { link = 'Conditional' },
   ['@keyword.return']      = { fg = mono.fg.emph, italic = true },

   --- Language-specific  ------------------------------------------------------
   -- bash.
   ['@variable.bash'] = { link = 'Identifier' },
   ['@constant.bash'] = { link = '@variable.bash' },
   ['@punctuation.special.bash'] = { link = '@variable.bash' },

   -- elixir.
   ['@module.elixir']    = { link = 'Type'       },
   ['@keyword.elixir']   = { link = 'Operator'   },
   ['@function.elixir']  = { link = 'Identifier' },

   -- scheme.
   ['@variable.scheme']  = { link = 'Identifier' },
   ['@keyword.scheme']   = { italic = true },
   ['@function.builtin.scheme'] = { italic = true },

   -- Asciidoc.
   ['asciidocURL']            = { link = '@text.uri' },
   ['asciidocLineBreak']      = { fg = color.fg.norm },
   ['asciidocAttributeEntry'] = { fg = color.fg.norm },
   ['asciidocAttributeList']  = { fg = mono.fg.dim   },
   ['asciidocMacro']          = { fg = color.fg.dim  },
   ['asciidocListingBlock']   = { fg = mono.fg.dim   },
   ['asciidocBlockTitle']     = { fg = mono.fg.emph, italic = true },

   -- markdown.
   ['@markup.heading']      = { fg = mono.fg.emph, bold = true },
   ['@markup.heading.1']    = { fg = mono.fg.emph, bold = true, underline = true },
   ['@markup.heading.2']    = { link = '@markup.heading.1' },
   ['@markup.strong']       = { bold = true        },
   ['@markup.italic']       = { italic = true      },
   ['@label.markdown']      = { link = 'Type'      },
   ['@markup.raw']          = { link = 'Type'      },
   ['@markup.link.label']   = { link = '@text.uri' },
   ['@markup.link.url']     = { link = 'Comment'   },

   --- Plugins -----------------------------------------------------------------
   --- lazy.nvim ---------------------------------------------------------------
   -- Just :Inspect the element in the :Lazy ui and change its highlight or
   -- whatever.
   LazyNormal       = { bg = mono.bg[-1] },
   LazyH1           = { fg = mono.fg.emph },
   LazyReasonPlugin = { fg = fg },
   LazySpecial      = { fg = fg },
   LazyProp         = { fg = mono.fg.dim },
   LazyButton       = { fg = mono.fg.dim, bg = mono.bg[0] },
   LazyReasonStart  = { fg = color.fg.norm },
   LazyReasonCmd    = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyCommit       = { link = 'Comment' },

   --- nvim-treesitter-context -------------------------------------------------
   TreesitterContext = { bg = mono.bg[1] },

   -- LSP nonsense
   DiagnosticHint             = { link = 'Comment'  },
   DiagnosticInfo             = { link = 'Comment'  },
   DiagnosticWarn             = { fg = fg           },
   DiagnosticError            = { fg = mono.fg.dim  },
   DiagnosticVirtualTextHint  = { link = 'Comment'  },
   DiagnosticVirtualTextInfo  = { link = 'Comment'  },
   DiagnosticVirtualTextWarn  = { link = 'Comment'  },
   DiagnosticVirtualTextError = { fg = red.fg       },
   DiagnosticFloatingHint     = { fg = mono.fg.emph },
   DiagnosticFloatingInfo     = { fg = mono.fg.emph },
   DiagnosticFloatingWarn     = { fg = mono.fg.emph },
   DiagnosticFloatingError    = { fg = mono.fg.emph },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the same thing

}) do
   nvim_set_hl(0, name, highlight)
end

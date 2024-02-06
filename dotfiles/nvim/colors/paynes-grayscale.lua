-- vim: tw=80
-- paynes_grayscale
--
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

Yes emphasis
- Strings (white for escape chars)
- Types
- User-defined methods
- "Named values"
   - nil/none/null
   - true/false
- Control flow
   - if/else
   - cond/case
   - while/until

No emph.
- Statements
- Built-ins
- Operators

Grayscale should be used to push "less important" bits to the background. Still
visible, but less so. E.g., brackets. String start/end quotes.

Unimportant
- Brackets
- String start/end tokens
- Comments

Colors:
 #161a1d    co.bg[0]
 #22262b    co.bg[1]
 #2d333a    co.bg[2]
 #5a6673    co.fg.dim
 #708090    co.fg.norm

Monochrome:
bg:
 #000000    mc.bg[-2]
 #0d0d0d    mc.bg[-1]
 #121212    mc.bg[ 0]
 #181818    mc.bg[ 1]
 #222222    mc.bg[ 2]
 #282828    mc.bg[ 3]
fg:
 #404040    mc.fg.comment
 #707070    mc.fg.dim
 #b0b0b0    mc.fg.norm
 #f0f0f0    mc.fg.emph

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
      __index = function (tbl, key)
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

   --- Text --------------------------------------------------------------------
   Comment    = { fg = mono.fg.comment },
   NonText    = { link = 'Normal' },
   Todo       = { fg = yellow },
   DiffAdd    = { fg = fg, bg = green.bg },
   DiffDelete = { fg = mono.bg[1], bg = bg },
   DiffChange = { fg = fg, bg = blue.bg[0] },
   DiffText   = { fg = mono.fg.emph, bg = blue.bg[1], bold = true },
   SpellBad   = { fg = mono.fg.emph, bg = red.bg[0] },
   SpellLocal = { fg = mono.fg.emph, bg = blue.bg[0] },
   Conceal    = { link = 'Comment' },

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
   Directory    = { fg = blue.bg[1] },
   Title        = { fg = blue.bg[1] },
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
   NormalFloat    = { bg = mono.bg[-1] },
   FloatBorder    = { fg = color.fg.dim, bg = mono.bg[0] },
   FloatShadow    = { bg = color.bg[0] },
   FloatShadowThrough = { bg = bg },

   -- TODO: To add from `:h highlight-groups` docs:
   --[[
      Substitute        `:s`  replacement text highlighting
      ModeMsg
      ModeArea
      MsgSeparator
   --]]

   --- Literals ----------------------------------------------------------------
   Boolean    = { fg = mono.fg.emph },
   String     = { fg = color.fg.dim },
   Constant   = { link = 'Normal'   },
   Float      = { link = 'Normal'   },
   Number     = { link = 'Normal'   },
   Character  = { link = 'String'   },
   SpecialKey = { link = 'Special'  }, -- Lit. repr of ^V, ^C, etc.

   --- Language features, built-ins, etc. --------------------------------------
   Statement   = { link = 'Normal' },
   Keyword     = { link = 'Normal' },
   Special     = { link = 'Normal' },
   Macro       = { link = 'Normal' },
   Function    = { link = 'Normal' },
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

   --['@keyword.repeat']      = { link = 'Repeat'      },
   --['@keyword.conditional'] = { link = 'Conditional' },

   --- Language-specific  ------------------------------------------------------
   ['@variable.bash'] = { link = 'Identifier' },
   ['@constant.bash'] = { link = '@variable.bash' },
   ['@punctuation.special.bash'] = { link = '@variable.bash' },

   --- Plugins -----------------------------------------------------------------
   --- lazy.nvim ---------------------------------------------------------------
   -- Just :Inspect the element in the :Lazy ui and change its highlight or
   -- whatever.
   LazyH1           = { fg = mono.fg.emph },
   LazyReasonPlugin = { fg = fg },
   LazySpecial      = { fg = fg },
   LazyProp         = { fg = mono.fg.dim },
   LazyButton       = { fg = mono.fg.dim, bg = bg },
   LazyReasonStart  = { fg = color.fg.norm },
   LazyReasonCmd    = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyCommit       = { link = 'Comment' },

   --- nvim-treesitter-context -------------------------------------------------
   TreesitterContext = { bg = mono.bg[1] },

   -- LSP nonsense
   DiagnosticHint             = { link = 'Comment' },
   DiagnosticInfo             = { link = 'Comment' },
   DiagnosticWarn             = { fg = fg },
   DiagnosticError            = { fg = mono.fg.dim },
   DiagnosticVirtualTextHint  = { link = 'Comment' },
   DiagnosticVirtualTextInfo  = { link = 'Comment' },
   DiagnosticVirtualTextWarn  = { link = 'Comment' },
   DiagnosticVirtualTextError = { fg = red.fg },
   DiagnosticFloatingHint     = { fg = mono.fg.emph },
   DiagnosticFloatingInfo     = { fg = mono.fg.emph },
   DiagnosticFloatingWarn     = { fg = mono.fg.emph },
   DiagnosticFloatingError    = { fg = mono.fg.emph },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the same thing

}) do
   nvim_set_hl(0, name, highlight)
end






--[[ 2024-02-03, colors update

After several months of use, several tweaks are necessary:

   (1) Background colors were too far apart. Made for difficult popup windows.

      "#000000"
      "#090909"
      "#0d0d0d"
      "#121212"  #< bg[0]?
      "#161616"
      "#1b1b1b"

      May want to shift the background color darker by 1, think it is more
      useful to have colors above bg[0] RAERPB below it.
      

   (2) Foreground contrast needs to be greater for low-light

      Re-thinking having +2 above-fg colors. Little difficult to see the
      differentiation. May want to do a bit more with bold and italic. Both are
      feeling underutilized.

      Use for italics?
         types

      Use for bold?
         constants
         types
         flow control

      I think it's better to start by only touching the bg colors. Can use
      emphasis in the form of bold/italic for fg. Revisit after.

--]]
--[[ 2024-02-04, more thinkies

I believe I've come to the conclusion that there are too many foreground colors.
There should be exactly 4 monochrome colors.
   - COMMENT #404040
   - dim     #707070
   - normal  #b0b0b0
   - bright  #f0f0f0

Then perhaps only 1 or two colored monochrome colors:
   - dim      #536878
   - normal   #708090

Bright w/ color is too similar to uncolored bright.

TODO:    All `@' color groups need to link to their normal equivalent. E.g.,
            @boolean -> Boolean
            @field   -> Field
         Ensures that when there's no treesitter, colors are still (mostly)
         behaving as expected. Obviously can't use in the case where there is no
         normal vim HL group.

--]]

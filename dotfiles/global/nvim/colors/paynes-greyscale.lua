-- vim: ft=lua tw=80 foldmethod=marker
--
-- Name:       paynes-greyscale
-- Maintainer: sr.ht/~carlinigraphy, github.com/carlinigraphy
-- License:    Unlicense

--[[

Refinement of my previous colorschemes. Guiding principals:

   (1) Colors must aid in understanding of the text.

       E.g., strings have a unique highlight. It is important to recognize
       strings apart from code. It is more important to recognize interpolation
       within a string.

       Syntax highlighting visually cues where the string is, and isn't.

   (2) Color emphasis should mirror code importance.

       The eye is drawn to high contrast. A very bright white on a black
       background is more visually distinct than a mid-grey. Colors should 'pop'
       to carry information.

       Control flow is important to easily distinguish, thus it is useful to
       increase contrast. Comments can be pushed to the background, and require
       more intentionality to read.

--]]---------------------------------------------------------------------------

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
    vim.cmd('syntax reset')
end

vim.g.colors_name = 'paynes-greyscale'


--- Regular colors -------------------------------------------------------------
local mono = {
   bg = {
      [-2] = '#0e0e0e',
      [-1] = '#101010',
      [ 0] = '#121212',
      [ 1] = '#141414',
      [ 2] = '#161616',
   },
   fg = {
     comment = '#404040',
     dim     = '#707070',
     norm    = '#b5b5b5',
     emph    = '#ffffff',
   },
}

local color = {
   bg = {
     [ 0] = '#161a1d',
     [ 1] = '#22262b',
     [ 2] = '#2d333a',
   },
   fg = {
      dim  = '#536878',
      norm = '#708090',
   },
}


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
   fg = '#9b4a6b',
}


--------------------------------------------------------------------------------
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
local nvim_set_hl = vim.api.nvim_set_hl

local fg = mono.fg.norm
local bg = mono.bg[0]

for name, highlight in pairs({
   -- Root groups.
   Normal        = { fg = fg, bg = bg  },
   Paynes_Dim    = { fg = mono.fg.dim  },
   Paynes_Emph   = { fg = mono.fg.emph },


   --[[  -2  Background  ----------------------------------------------------{{{
   Must have capacity for legibility, but can easily slip into the
   background.
         - comments
         - concealed text
         - folded text
         - line numbers
   ---------------------------------------------------------------------------]]
   SignColumn     = { bg = bg },
   Comment        = { fg = mono.fg.comment },
   Conceal        = { link = 'Comment' },
   EndOfBuffer    = { link = 'Comment' },
   LineNr         = { link = 'Comment' },
   LineNrAbove    = { link = 'Comment' },
   LineNrBelow    = { link = 'Comment' },
   NonText        = { link = 'Comment' },
   WinSeparator   = { link = 'Comment' },

   Folded         = { fg = mono.fg.comment, bg = mono.bg[1] },
   CursorColumn   = { link = 'Folded' },
   CursorLine     = { link = 'Folded' },
   CursorLineNr   = { link = 'Normal' },

   FoldColumn     = { fg = color.bg[2], bg = bg },
   CursorLineFold = { link = 'FoldColumn' },
   --}}}


   --[[  -1  Dim  -----------------------------------------------------------{{{
   Legible, but "noisy".
         - common language keywords: def, let, const
         - operators
         - delimiters: parens, brackets
   ---------------------------------------------------------------------------]]
   Define           = { link = 'Paynes_Dim' },
   Keyword          = { link = 'Paynes_Dim' },
   Operator         = { link = 'Paynes_Dim' },
   PreProc          = { link = 'Paynes_Dim' },
   Delimiter        = { link = 'Paynes_Dim' },
   ['@bracket']     = { link = 'Paynes_Dim' },
   ['@punctuation'] = { link = 'Paynes_Dim' },
   ['@constructor'] = { link = 'Paynes_Dim' },
   ---}}}


   --[[   0  Normal  ---------------------------------------------------------{{{
   Regular text. Should be easily legible, but not overly bright and
   emphasized.
         - statements
         - numbers (unnecessary to color, it's a visually distinct symbol)
   ---------------------------------------------------------------------------]]
   Constant      = { link = 'Normal' },
   Float         = { link = 'Normal' },
   Function      = { link = 'Normal' },
   Macro         = { link = 'Normal' },
   MoreMsg       = { link = 'Normal' },
   Number        = { link = 'Normal' },
   Question      = { link = 'Normal' },
   Statement     = { link = 'Normal' },
   ['@field']    = { link = 'Normal' },
   ['@function.builtin'] = { link = 'Function' },
   ['@string.regex']     = { link = 'Function' },

   -- REVIEW: for lua, this table keys, which should not be emphasized. Does
   -- that apply to other languages? Maybe they make sense to be highlighted
   -- elsewhere.
   ['@property'] = { link = 'Normal' },
   --}}}


   --[[  +1  Emphasis  ------------------------------------------------------{{{
   Content requiring additional attention. Should be clearly visible, and likely
   the important content of a line.
         - identifiers
         - types
         - strings
   ---------------------------------------------------------------------------]]
   Boolean        = { fg = color.fg.norm, bold = true },
   Exception      = { link = 'Paynes_Emph' },
   Identifier     = { link = 'Paynes_Emph' },
   ['@variable']  = { link = 'Identifier' },
   ['@constant']  = { link = 'Identifier' },

   Type           = { fg = color.fg.norm },
   TypeDef        = { link = 'Type' },
   ['@module']    = { link = 'Type' },

   String         = { fg = color.fg.dim },
   Character      = { link = 'String' },
   --}}}


   --[[  +2  Important  -----------------------------------------------------{{{
   Fundamentally changes the content of the text, or execution of a program.
         - control flow
         - todo/error messaging
   ---------------------------------------------------------------------------]]
   Conditional = { fg = mono.fg.emph, bold = true },
   Repeat      = { fg = mono.fg.emph, bold = true },

   Todo                 = { fg = yellow, bold = true },
   WarningMsg           = { link = 'Todo' },
   ['@comment.todo']    = { link = 'Todo' },
   ['@comment.warning'] = { link = 'Todo' },
   ['@comment.error']   = { link = 'Todo' },
   ['@comment.note']    = { link = 'Todo' },


   DiffAdd      = { fg = fg, bg = green.bg },
   DiffChange   = { fg = fg, bg = blue.bg[0] },
   DiffDelete   = { fg = mono.bg[1], bg = bg },
   DiffText     = { fg = mono.fg.emph, bg = blue.bg[1], bold = true },
   Directory    = { fg = color.fg.norm, bold = true },
   ErrorMsg     = { fg = red.fg },
   MatchParen   = { fg = mono.fg.emph, bg = blue.bg[1], bold = true },
   Title        = { fg = mono.fg.emph, bold = true, underline = true },

   Error        = { fg = mono.fg.emph, bg = red.bg[0] },
   ['@error']   = { link = 'Error' },
   SpellBad     = { link = 'Error' },
   SpellCap     = {},
   SpellLocal   = {},
   SpellRare    = {},

   Visual       = { fg = mono.bg[-2], bg = mono.fg.norm, bold = true },
   CurSearch    = { link = 'Visual' },
   Substitute   = { link = 'Visual' },
   Search       = { link = 'Visual' },
   QuickFixLine = { link = 'Visual' },
   IncSearch    = { link = 'Visual' },

   Special      = { fg = color.fg.norm, italic = true },
   SpecialKey   = { link = 'Special' },
   SpecialChar  = { link = 'Special' },

   ['@string.special.url']  = { fg = color.fg.norm, underline = true },
   ['@keyword.return']      = { fg = mono.fg.emph, italic = true },
   ['@keyword.operator']    = { link = 'Operator'    },
   ['@keyword.repeat']      = { link = 'Repeat'      },
   ['@keyword.conditional'] = { link = 'Conditional' },
   --}}}


   --[[  Special  -----------------------------------------------------------{{{
   Nonsense that kinds doesn't fit anywhere else.
   ---------------------------------------------------------------------------]]

   --- UI elements -------------------------------------------------------------
   Pmenu        = { fg = mono.fg.dim, bg = mono.bg[1] },
   PmenuSbar    = { bg = color.bg[0] },
   PmenuSel     = { fg = fg, bg = mono.bg[2], bold = true },
   PmenuThumb   = { bg = color.bg[2] },

   -- My statusline groups.
   Statusline_Filetype     = { fg = fg, bg = bg },
   Statusline_Cursor       = { fg = mono.fg.emph, bg = mono.bg[1]  , bold = true },
   Statusline_Mode_Normal  = { fg = mono.fg.emph, bg = blue.bg[0]  , bold = true },
   Statusline_Mode_Insert  = { fg = mono.fg.emph, bg = green.bg    , bold = true },
   Statusline_Mode_Visual  = { fg = mono.fg.emph, bg = color.bg[0] , bold = true },
   Statusline_Mode_Replace = { fg = mono.fg.emph, bg = red.bg[0]   , bold = true },

   -- Built-in statusline groups.
   StatusLineNC = { fg = mono.fg.dim, bg = mono.bg[1] },
   StatusLine   = { fg = fg, bg = mono.bg[1] },

   -- Floating windows.
   FloatBorder        = { fg = mono.bg[-2] , bg = mono.bg[1] },
   FloatFooter        = { link = 'Title' },
   FloatShadow        = { bg = mono.bg[-1] },
   FloatShadowThrough = { link = 'Normal' },
   FloatTitle         = { link = 'Title' },
   NormalFloat        = { bg = mono.bg[2] },

   -- Language specific --------------------------------------------------------
   -----------------------------------------------------------------------------

   -- bash.
   ['@punctuation.special.bash'] = { link = 'Identifier' },

   -- scheme.
   ['@keyword.scheme']          = { italic = true },
   ['@function.builtin.scheme'] = { italic = true },

   -- Asciidoc.
   ['asciidocAttributeEntry'] = { fg = color.fg.norm },
   ['asciidocAttributeList']  = { fg = mono.fg.dim },
   ['asciidocBlockTitle']     = { fg = mono.fg.emph, italic = true },
   ['asciidocLineBreak']      = { fg = color.fg.norm },
   ['asciidocListingBlock']   = { fg = mono.fg.dim },
   ['asciidocMacro']          = { fg = color.fg.dim },
   ['asciidocURL']            = { link = '@string.special.url' },

   -- C
   ['@type.builtin.c'] = { fg = mono.fg.dim },

   -- markup (misc.)
   ['@markup.heading']    = { fg = mono.fg.emph  },
   ['@markup.heading.1']  = { fg = mono.fg.emph, bold = true },
   ['@markup.heading.2']  = { fg = mono.fg.emph, bold = true },
   ['@markup.strong']     = { bold = true },
   ['@markup.bold']       = { bold = true },
   ['@markup.italic']     = { italic = true },
   ['@markup.raw']        = { link = 'String' },
   ['@markup.link.label'] = { link = 'Comment' },
   ['@markup.link.url']   = { link = 'Comment' },

   -- Markdown specific
   ['@label.markdown'] = { link = 'Type' },
   ['@markup.heading.1.markdown'] = { fg = mono.fg.emph, bold = true, underline = true },

   --- Plugins -----------------------------------------------------------------
   -----------------------------------------------------------------------------

   -- lazy.nvim
   LazyNormal       = { bg = mono.bg[1] },
   LazyButton       = { fg = mono.fg.norm, bg = mono.bg[2] },
   LazyCommit       = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyH1           = { link = 'Paynes_Emph' },
   LazyProp         = { link = 'Paynes_Dim' },
   LazyReasonCmd    = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyReasonPlugin = { fg = fg },
   LazyReasonStart  = { link = 'Normal' },
   LazySpecial      = { link = 'Paynes_Emph' },

   -- nvim-treesitter-context
   TreesitterContext = { bg = mono.bg[1] },

   -- lsp
   DiagnosticError            = { fg = mono.fg.dim  },
   DiagnosticFloatingError    = { link = 'Paynes_Emph' },
   DiagnosticFloatingHint     = { link = 'Paynes_Emph' },
   DiagnosticFloatingInfo     = { link = 'Paynes_Emph' },
   DiagnosticFloatingWarn     = { link = 'Paynes_Emph' },
   DiagnosticHint             = { link = 'Comment' },
   DiagnosticInfo             = { link = 'Comment' },
   DiagnosticVirtualTextError = { fg = red.fg },
   DiagnosticVirtualTextHint  = { link = 'Comment' },
   DiagnosticVirtualTextInfo  = { link = 'Comment' },
   DiagnosticVirtualTextWarn  = { link = 'Comment' },
   DiagnosticWarn             = { fg = fg },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the
   --  same thing
   --}}}


}) do
   nvim_set_hl(0, name, highlight)
end

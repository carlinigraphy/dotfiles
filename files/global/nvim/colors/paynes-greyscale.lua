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
     [ 0] = '#1b2227',
     [ 1] = '#2b363e'
   },
   fg = {
      dim  = '#536878',
      norm = '#708090',
   },
}


--- Special/accent colors ------------------------------------------------------
local yellow = '#eb9753'

local green  = {
   bg = '#222f30',
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
   PaynesDim     = { fg = mono.fg.dim  },
   PaynesEmph    = { fg = mono.fg.emph },


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

   Folded         = { fg = mono.fg.dim, bg = mono.bg[1] },
   CursorColumn   = { bg = mono.bg[1] },
   CursorLine     = { bg = mono.bg[1] },
   CursorLineNr   = { bg = mono.bg[1] },

   FoldColumn     = { fg = mono.fg.comment, bg = bg },
   CursorLineFold = { link = 'FoldColumn' },
   --}}}


   --[[  -1  Dim  -----------------------------------------------------------{{{
   Legible, but "noisy".
         - common language keywords: def, let, const
         - operators
         - delimiters: parens, brackets
   ---------------------------------------------------------------------------]]
   Define           = { link = 'PaynesDim' },
   Keyword          = { link = 'PaynesDim' },
   Operator         = { link = 'PaynesDim' },
   PreProc          = { link = 'PaynesDim' },
   Delimiter        = { link = 'PaynesDim' },
   ['@bracket']     = { link = 'PaynesDim' },
   ['@punctuation'] = { link = 'PaynesDim' },
   ['@constructor'] = { link = 'PaynesDim' },
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
   Exception      = { link = 'PaynesEmph' },
   Identifier     = { link = 'PaynesEmph' },
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

   DiffAdd      = { fg = mono.fg.emph, bg = green.bg },
   DiffChange   = { fg = fg, bg = color.bg[0] },
   DiffDelete   = { fg = mono.bg[2], bg = bg },
   DiffText     = { fg = mono.fg.emph, bg = color.bg[1], bold = true },
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
   PmenuSel     = { fg = fg, bg = mono.bg[1], bold = true },
   PmenuThumb   = { bg = color.bg[1] },

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
   FloatBorder        = { fg = color.fg.norm },
   FloatFooter        = { link = 'Title' },
   FloatShadow        = { bg = mono.bg[-1] },
   FloatShadowThrough = { link = 'Normal' },
   FloatTitle         = { link = 'Title' },
   NormalFloat        = { bg = mono.bg[0] },

   -- Language specific --------------------------------------------------------
   -----------------------------------------------------------------------------

   -- bash.
   ['@punctuation.special.bash'] = { link = 'Identifier' },

   -- scheme.
   ['@keyword.scheme']          = { italic = true },
   ['@keyword.racket']          = { italic = true },
   ['@function.builtin.scheme'] = { italic = true },
   ['@function.builtin.racket'] = { italic = true },

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

   -- Beancount.
   ['@markup.italic.beancount'] = { fg = mono.fg.emph, italic = true },

   --- Plugins -----------------------------------------------------------------
   -----------------------------------------------------------------------------

   -- lazy.nvim
   LazyNormal       = { bg = mono.bg[0] },
   LazyButton       = { fg = mono.fg.norm, bg = mono.bg[2] },
   LazyCommit       = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyH1           = { link = 'PaynesEmph' },
   LazyProp         = { link = 'PaynesDim' },
   LazyReasonCmd    = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyReasonPlugin = { fg = fg },
   LazyReasonStart  = { link = 'Normal' },
   LazySpecial      = { link = 'PaynesEmph' },

   -- nvim-treesitter-context
   TreesitterContext = { bg = mono.bg[1] },

   -- lsp
   DiagnosticError            = { fg = mono.fg.dim  },
   DiagnosticFloatingError    = { link = 'PaynesEmph' },
   DiagnosticFloatingHint     = { link = 'PaynesEmph' },
   DiagnosticFloatingInfo     = { link = 'PaynesEmph' },
   DiagnosticFloatingWarn     = { link = 'PaynesEmph' },
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

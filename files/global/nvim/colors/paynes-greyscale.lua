-- vim: ft=lua tw=80 foldmethod=marker
--
-- Name:       paynes-greyscale
-- Maintainer: sr.ht/~carlinigraphy, github.com/carlinigraphy
-- License:    Unlicense

--[[----------------------------------------------------------------------------

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

local bg = {
   -- Values obtained by setting my laptop to ~3% brightness, drawing windows,
   -- boxes, and buttons, and determining the minimum step required for
   -- legibility. On my laptop, to my eye.
   mono = {
      [-2] = '#000000',
      [-1] = '#0d0d0d',
      [ 0] = '#121212',
      [ 1] = '#151515',
      [ 2] = '#181818',
      [ 3] = '#202020',
   },
   red = '#572d41'
}

local fg = {
   mono = {
     black   = '#000000',
     comment = '#404040',
     dim     = '#808080',
     norm    = '#b0b0b0',
     emph    = '#ffffff',
   },
   accent = {
      paynes = '#536878',
      slate  = '#708090',
   },
   red = '#9b4a6b',
   yellow = '#f0a96e',
}


--------------------------------------------------------------------------------
for _, tbl in ipairs({
   bg.mono, fg.mono, fg.accent,
}) do
   setmetatable(tbl, {
      __index = function (_, key)
         error(("Invalid index '%s'"):format(key), 2)
      end
   })
end

--------------------------------------------------------------------------------
for name, highlight in pairs({
   -- Root groups.
   Normal        = { fg = fg.mono.norm },
   PaynesDim     = { fg = fg.mono.dim  },
   PaynesEmph    = { fg = fg.mono.emph },


   --[[  -2  Background  ----------------------------------------------------{{{
   Must have capacity for legibility, but can easily slip into the
   background.
         - comments
         - concealed text
         - folded text
         - line numbers
   ---------------------------------------------------------------------------]]
   SignColumn     = { bg = bg.mono[0] },
   Comment        = { fg = fg.mono.comment },
   Conceal        = { link = 'Comment' },
   EndOfBuffer    = { link = 'Comment' },
   LineNr         = { link = 'Comment' },
   LineNrAbove    = { link = 'Comment' },
   LineNrBelow    = { link = 'Comment' },
   NonText        = { link = 'Comment' },
   WinSeparator   = { link = 'Comment' },

   Folded         = { fg = fg.mono.dim, bg = bg.mono[1] },
   CursorLine     = { bg = bg.mono[1] },
   CursorColumn   = { link = 'CursorLine' },
   CursorLineNr   = { link = 'CursorLine' },
   ColorColumn    = { link = 'CursorLine' },

   FoldColumn     = { fg = fg.mono.comment, bg = bg.mono[0] },
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
   Boolean        = { fg = fg.accent.slate, bold = true },
   Exception      = { link = 'PaynesEmph' },
   Identifier     = { link = 'PaynesEmph' },
   ['@variable']  = { link = 'Identifier' },
   ['@constant']  = { link = 'Identifier' },

   Type           = { fg = fg.accent.slate },
   TypeDef        = { link = 'Type' },
   Label          = { link = 'Type' },
   ['@module']    = { link = 'Type' },

   String         = { fg = fg.accent.paynes },
   Character      = { link = 'String' },
   --}}}


   --[[  +2  Important  -----------------------------------------------------{{{
   Fundamentally changes the content of the text, or execution of a program.
         - control flow
         - todo/error messaging
   ---------------------------------------------------------------------------]]
   Conditional = { fg = fg.mono.emph, bold = true },
   Repeat      = { fg = fg.mono.emph, bold = true },

   Todo                 = { fg = fg.yellow, bold = true },
   WarningMsg           = { link = 'Todo' },
   ['@comment.todo']    = { link = 'Todo' },
   ['@comment.warning'] = { link = 'Todo' },
   ['@comment.error']   = { link = 'Todo' },
   ['@comment.note']    = { link = 'Todo' },

   DiffAdd      = { bg = bg.mono[3] },
   DiffChange   = { fg = fg.mono.dim, bg = bg.mono[3] },
   DiffText     = { fg = fg.mono.emph, bg = bg.mono[3], bold = true },
   DiffDelete   = { fg = bg.mono[3], bg = bg.mono[0] },
   Directory    = { fg = fg.accent.slate, bold = true },
   ErrorMsg     = { fg = fg.red },
   MatchParen   = { fg = fg.mono.emph, bg = fg.accent.paynes, bold = true },
   Title        = { fg = fg.mono.emph, bold = true, underline = true },

   Error        = { fg = fg.mono.emph, bg = bg.red },
   ['@error']   = { link = 'Error' },

   SpellBad     = { fg = fg.red, sp = fg.mono.dim, italic = true, underdashed = true, },
   SpellLocal   = {},
   SpellCap     = {},
   SpellRare    = {},

   Visual       = { fg = fg.mono.black, bg = fg.mono.norm, bold = true },
   CurSearch    = { link = 'Visual' },
   Substitute   = { link = 'Visual' },
   Search       = { link = 'Visual' },
   QuickFixLine = { link = 'Visual' },
   IncSearch    = { link = 'Visual' },

   Special      = { fg = fg.accent.slate, italic = true },
   SpecialKey   = { link = 'Special' },
   SpecialChar  = { link = 'Special' },

   ['@string.special.url']  = { fg = fg.accent.slate, underline = true },
   ['@keyword.return']      = { fg = fg.mono.emph, italic = true },
   ['@keyword.operator']    = { link = 'Operator'    },
   ['@keyword.repeat']      = { link = 'Repeat'      },
   ['@keyword.conditional'] = { link = 'Conditional' },
   --}}}


   --[[  Special  -----------------------------------------------------------{{{
   Nonsense that kinds doesn't fit anywhere else.
   ---------------------------------------------------------------------------]]

   --- UI elements -------------------------------------------------------------
   Pmenu        = { fg = fg.mono.dim, bg = bg.mono[1] },
   PmenuSbar    = { bg = bg.mono[3] },
   PmenuSel     = { fg = fg.mono.emph, bg = bg.mono[3], bold = true },
   PmenuThumb   = { bg = fg.accent.paynes },

   -- My statusline groups.
   Statusline_Filetype     = { fg = fg.mono.norm  , bg = bg.mono[2] },
   Statusline_Cursor       = { fg = fg.mono.emph  , bg = bg.mono[2], bold = true },
   Statusline_Mode_Normal  = { fg = fg.mono.norm  , bg = bg.mono[2], bold = true },
   Statusline_Mode_Insert  = { fg = fg.mono.emph  , bg = bg.mono[2], bold = true },
   Statusline_Mode_Visual  = { fg = fg.mono.norm  , bg = bg.mono[2], bold = true },
   Statusline_Mode_Replace = { fg = fg.red        , bg = bg.mono[2], bold = true },

   -- Built-in statusline groups.
   StatusLineNC = { fg = fg.mono.dim , bg = bg.mono[2] },
   StatusLine   = { fg = fg.mono.norm, bg = bg.mono[2] },

   -- Floating windows.
   FloatBorder        = { fg = fg.accent.slate },
   FloatFooter        = { link = 'Title' },
   FloatShadow        = { bg = bg.mono[-1] },
   FloatShadowThrough = { link = 'Normal' },
   FloatTitle         = { link = 'Title' },
   NormalFloat        = { bg = bg.mono[0] },

   -- lsp
   DiagnosticError            = { fg = fg.mono.dim  },
   DiagnosticFloatingError    = { link = 'PaynesEmph' },
   DiagnosticFloatingHint     = { link = 'PaynesEmph' },
   DiagnosticFloatingInfo     = { link = 'PaynesEmph' },
   DiagnosticFloatingWarn     = { link = 'PaynesEmph' },
   DiagnosticHint             = { link = 'Comment' },
   DiagnosticInfo             = { link = 'Comment' },
   DiagnosticVirtualTextError = { fg = fg.red },
   DiagnosticVirtualTextHint  = { link = 'Comment' },
   DiagnosticVirtualTextInfo  = { link = 'Comment' },
   DiagnosticVirtualTextWarn  = { link = 'Comment' },
   DiagnosticWarn             = { fg = fg.mono.norm },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the
   --  same thing

   -- Language specific --------------------------------------------------------
   -----------------------------------------------------------------------------
   -- man.
   ['manBold']       = { fg = fg.mono.emph, bold = true },
   ['manUnderline']  = { italic = true },
   ['manReference']  = { link = "@string.special.url" },
   ['manOptionDesc'] = { fg = fg.mono.emph },

   -- bash.
   ['@punctuation.special.bash'] = { link = 'Identifier' },

   -- scheme.
   ['@function.builtin.racket'] = { italic = true },
   ['@function.builtin.scheme'] = { italic = true },
   ['@keyword.racket']          = { italic = true },
   ['@keyword.scheme']          = { italic = true },

   -- Asciidoc.
   ['asciidocAttributeEntry'] = { fg = fg.accent.slate },
   ['asciidocAttributeList']  = { fg = fg.mono.dim },
   ['asciidocBlockTitle']     = { fg = fg.mono.emph, italic = true },
   ['asciidocLineBreak']      = { fg = fg.accent.slate },
   ['asciidocListingBlock']   = { fg = fg.mono.dim },
   ['asciidocMacro']          = { fg = fg.accent.paynes },
   ['asciidocURL']            = { link = '@string.special.url' },

   -- C
   ['@type.builtin.c'] = { fg = fg.mono.dim },

   -- markup (misc.)
   ['@markup.bold']       = { bold = true },
   ['@markup.heading']    = { fg = fg.mono.emph  },
   ['@markup.heading.1']  = { fg = fg.mono.emph, bold = true },
   ['@markup.heading.2']  = { fg = fg.mono.emph, bold = true },
   ['@markup.italic']     = { italic = true },
   ['@markup.link.label'] = { link = '@string.special.url' },
   ['@markup.link.url']   = { link = '@string.special.url' },
   ['@markup.list']       = { link = 'Delimiter' },
   ['@markup.raw']        = { link = 'String' },
   ['@markup.strong']     = { bold = true },

   -- Markdown specific
   -- Stops things like `vimdoc` from also having underlined top-level headings.
   ['@markup.heading.1.markdown'] = { fg = fg.mono.emph, bold = true, underline = true },

   -- Beancount.
   ['@markup.italic.beancount'] = { fg = fg.mono.emph, italic = true },

   --- Plugins -----------------------------------------------------------------
   -----------------------------------------------------------------------------

   -- nvim-treesitter-context
   TreesitterContext = { bg = bg.mono[1] },

   -- lazy.nvim
   LazyNormal       = { bg = bg.mono[0] },
   LazyButton       = { fg = fg.mono.norm, bg = bg.mono[2] },
   LazyCommit       = { link = 'Comment' },
   LazyCommitType   = { link = 'Comment' },
   LazyH1           = { link = 'PaynesEmph' },
   LazyProp         = { link = 'PaynesDim' },
   LazyReasonCmd    = { link = 'Comment' },
   LazyReasonFt     = { link = 'Comment' },
   LazyReasonPlugin = { fg = fg.mono.norm },
   LazyReasonStart  = { link = 'Normal' },
   LazySpecial      = { link = 'PaynesEmph' },

   MasonHighlight          = { fg = fg.accent.paynes },
   MasonHighlightSecondary = { fg = fg.accent.slate },
   MasonMutedBlock         = { fg = fg.mono.norm, bg = bg.mono[2] },
   MasonHighlightBlockBold = { link = 'Visual' },
   --}}}

}) do
   vim.api.nvim_set_hl(0, name, highlight)
end

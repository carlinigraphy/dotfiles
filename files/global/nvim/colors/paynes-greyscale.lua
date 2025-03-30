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

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.g.colors_name = "paynes-greyscale"

local bg = {
   -- Values obtained by setting my laptop to ~3% brightness, drawing windows,
   -- boxes, and buttons, and determining the minimum step required for
   -- legibility. On my laptop, to my eye.
   [-2] = "#000000",
   [-1] = "#0d0d0d",
   [ 0] = "#121212",
   [ 1] = "#151515",
   [ 2] = "#181818",
   [ 3] = "#202020",

   red  = "#572d41"
}

local fg = {
   -- Monochrome.
   [0] = "#404040",
   [1] = "#606060",
   [2] = "#909090",
   [3] = "#d0d0d0",
   [4] = "#ffffff",

   -- Accent.
   paynes  = "#536878",
   slate   = "#708090",

   -- Color.
   red     = "#ae6878",
   yellow  = "#cba381",
}


--------------------------------------------------------------------------------
for _, tbl in ipairs({ bg, fg }) do
   setmetatable(tbl, {
      __index = function (_, key)
         error(("Invalid index '%s'"):format(key), 2)
      end
   })
end

--------------------------------------------------------------------------------
for name, highlight in pairs({
   Normal = { fg = fg[3] },

   -- For iterating in command mode.
   Paynes0 = { fg = fg[0] },
   Paynes1 = { fg = fg[1] },
   Paynes2 = { fg = fg[2] },
   Paynes3 = { fg = fg[3] },
   Paynes4 = { fg = fg[4] },

   --[[  Background  --------------------------------------------------------{{{
   Must have capacity for legibility, but can easily slip into the
   background.
         - comments
         - concealed text
         - folded text
         - line numbers
   ---------------------------------------------------------------------------]]
   SignColumn     = { bg = bg[0] },
   Comment        = { fg = fg[0] },
   Conceal        = { link = 'Comment' },
   EndOfBuffer    = { link = 'Comment' },
   LineNr         = { link = 'Comment' },
   LineNrAbove    = { link = 'Comment' },
   LineNrBelow    = { link = 'Comment' },
   NonText        = { link = 'Comment' },
   WinSeparator   = { link = 'Comment' },

   Folded         = { fg = fg[1], bg = bg[1] },
   CursorLine     = { bg = bg[1] },
   CursorColumn   = { link = 'CursorLine' },
   CursorLineNr   = { link = 'CursorLine' },
   ColorColumn    = { link = 'CursorLine' },

   FoldColumn     = { fg = fg[0], bg = bg[0] },
   CursorLineFold = { link = 'FoldColumn' },
   --}}}

   --[[  Dim  ---------------------------------------------------------------{{{
   Legible, but "noisy".
         - common language keywords: def, let, const
         - operators
         - delimiters: parens, brackets
         - numbers (unnecessary to color, it's a visually distinct symbol)
   ---------------------------------------------------------------------------]]

   -- These are quite dim, but ot fully background-y.
   Delimiter              = { fg = fg[1] },
   Operator               = { link = "Delimiter" },
   ["@bracket"]           = { link = "Delimiter" },
   ["@punctuation"]       = { link = "Delimiter" },
   ["@keyword.operator"]  = { link = "Delimiter" },
   ["@attribute"]         = { link = "Delimiter" },
   ["@attribute.builtin"] = { link = "Delimiter" },

   Define       = { fg = fg[2] },
   PreProc      = { fg = fg[2] },
   Keyword      = { fg = fg[2] },
   ["@keyword"] = { link = "Keyword" },
   ---}}}

   --[[  Normal  ------------------------------------------------------------{{{
   Regular text. Should be easily legible, but not overly bright and
   emphasized.
         - statements
   ---------------------------------------------------------------------------]]
   Constant   = { link = "Normal" },
   Macro      = { link = "Normal" },
   MoreMsg    = { link = "Normal" },
   Question   = { link = "Normal" },
   Statement  = { link = "Normal" },
   ["@field"] = { link = "Normal" },
   ["@variable.parameter"] = { link = "Normal" },

   Number      = { link = "Normal" },
   Float       = { link = "Number" },
   ["@number"] = { link = "Number" },

   Function              = { link = "Normal"   },
   ["@function"]         = { link = "Function" },
   ["@function.builtin"] = { link = "Function" },
   ["@function.call"]    = { link = "Function" },
   ["@constructor"]      = { link = "Function" },

   -- REVIEW: for lua, this table keys, which should not be emphasized. Does
   -- that apply to other languages? Maybe they make sense to be highlighted
   -- elsewhere.
   ["@property"] = { fg = fg[2] },
   --}}}

   --[[  Emphasis  ----------------------------------------------------------{{{
   Content requiring additional attention. Should be clearly visible, and likely
   the important content of a line.
         - identifiers
         - types
         - strings
   ---------------------------------------------------------------------------]]
   Boolean        = { fg = fg.slate, bold = true },
   Exception      = { fg = fg[4] },

   Identifier     = { fg = fg[4] },
   ["@variable"]  = { link = "Identifier" },
   ["@constant"]  = { link = "Identifier" },

   Type           = { fg = fg.slate },
   TypeDef        = { link = "Type" },
   Label          = { link = "Type" },
   ["@module"]    = { link = "Type" },

   String         = { fg = fg.paynes },
   Character      = { link = "String" },
   --}}}

   --[[  Important  ---------------------------------------------------------{{{
   Fundamentally changes the content of the text, or execution of a program.
         - control flow
         - todo/error messaging
   ---------------------------------------------------------------------------]]
   Conditional = { fg = fg[4], bold = true },
   Repeat      = { fg = fg[4], bold = true },

   Todo                 = { fg = fg.yellow, bold = true },
   WarningMsg           = { link = "Todo" },
   ["@comment.todo"]    = { link = "Todo" },
   ["@comment.warning"] = { link = "Todo" },
   ["@comment.error"]   = { link = "Todo" },
   ["@comment.note"]    = { link = "Todo" },

   DiffAdd      = { bg = bg[3] },
   DiffChange   = { fg = fg[3], bg = bg[3] },
   DiffText     = { fg = fg[4], bg = bg[3], bold = true },
   DiffDelete   = { fg = bg[3], bg = bg[0] },
   Directory    = { fg = fg.slate, bold = true },
   ErrorMsg     = { fg = fg.red },
   MatchParen   = { fg = fg[4], bg = fg.paynes, bold = true },
   Title        = { fg = fg[4], bold = true, underline = true },

   Error        = { fg = fg[4], bg = bg.red },
   ["@error"]   = { link = "Error" },

   SpellBad     = { fg = fg.red, sp = fg[3], italic = true },
   SpellLocal   = {},
   SpellCap     = {},
   SpellRare    = {},

   Visual       = { fg = bg[-2], bg = fg[3], bold = true },
   CurSearch    = { link = "Visual" },
   Substitute   = { link = "Visual" },
   Search       = { link = "Visual" },
   QuickFixLine = { link = "Visual" },
   IncSearch    = { link = "Visual" },

   Special           = { fg = fg.slate    },
   SpecialKey        = { link = "Special" },
   SpecialChar       = { link = "Special" },
   ["@string.regex"] = { link = "Special" },

   ["@string.special.url"]  = { fg = fg.slate, bold = true, underline = true },

   ["@keyword.return"]      = { fg = fg[4], italic = true },
   ["@keyword.repeat"]      = { link = "Repeat"      },
   ["@keyword.conditional"] = { link = "Conditional" },
   --}}}

   --[[  Special  -----------------------------------------------------------{{{
   Nonsense that kinds doesn't fit anywhere else.
   ---------------------------------------------------------------------------]]

   --- UI elements -------------------------------------------------------------
   Pmenu        = { fg = fg[3], bg = bg[1] },
   PmenuSbar    = { bg = bg[3] },
   PmenuSel     = { fg = fg[4], bg = bg[3], bold = true },
   PmenuThumb   = { bg = fg.paynes },

   -- My statusline groups.
   Statusline_Filetype     = { fg = fg[3]  , bg = bg[2] },
   Statusline_Cursor       = { fg = fg[4]  , bg = bg[2], bold = true },
   Statusline_Mode_Normal  = { fg = fg[3]  , bg = bg[2], bold = true },
   Statusline_Mode_Insert  = { fg = fg[4]  , bg = bg[2], bold = true },
   Statusline_Mode_Visual  = { fg = fg[3]  , bg = bg[2], bold = true },
   Statusline_Mode_Replace = { fg = fg.red        , bg = bg[2], bold = true },

   -- Built-in statusline groups.
   StatusLineNC = { fg = fg[3] , bg = bg[2] },
   StatusLine   = { fg = fg[3], bg = bg[2] },

   -- Floating windows.
   FloatBorder        = { fg = fg.slate },
   FloatFooter        = { link = "Title" },
   FloatShadow        = { bg = bg[-1] },
   FloatShadowThrough = { link = "Normal" },
   FloatTitle         = { link = "Title" },
   NormalFloat        = { bg = bg[0] },

   -- lsp
   DiagnosticError            = { fg = fg[3]  },
   DiagnosticFloatingError    = { fg = fg[3] },
   DiagnosticFloatingHint     = { fg = fg[3] },
   DiagnosticFloatingInfo     = { fg = fg[3] },
   DiagnosticFloatingWarn     = { fg = fg[3] },
   DiagnosticHint             = { link = "Comment" },
   DiagnosticInfo             = { link = "Comment" },
   DiagnosticVirtualTextError = { fg = fg.red },
   DiagnosticVirtualTextHint  = { link = "Comment" },
   DiagnosticVirtualTextInfo  = { link = "Comment" },
   DiagnosticVirtualTextWarn  = { link = "Comment" },
   DiagnosticWarn             = { fg = fg[3] },
   DiagnosticUnnecessary      = {},
   --^ Color for unused variables. Disable, as the LSP warnings also cover the
   --  same thing

   DapUIType            = { link = "Type" },
   DapUIScope           = { link = "@markup.heading.1" },
   DapUIBreakpointsPath = { link = "@markup.heading.1" },
   DapUIBreakpointsLine = { link = "LineNr" },
   DapUIBreakpointsInfo = { link = "Type" },
   DapUIDecoration      = { link = "Delimiter" },
   DapUIWatchesEmpty    = { link = "Todo" },
   DapUIWatchesValue    = { link = "@markup.heading.1" },
   DapUIModifiedValue   = { link = "Variable" },

   -- Language specific --------------------------------------------------------
   -----------------------------------------------------------------------------
   -- man.
   ["manBold"]       = { fg = fg[4], bold = true },
   ["manUnderline"]  = { italic = true },
   ["manReference"]  = { link = "@string.special.url" },
   ["manOptionDesc"] = { fg = fg[4] },

   -- bash.
   ["@punctuation.special.bash"] = { link = "Identifier" },

   -- scheme.
   ["@function.builtin.racket"] = { italic = true },
   ["@function.builtin.scheme"] = { italic = true },
   ["@keyword.racket"]          = { italic = true },
   ["@keyword.scheme"]          = { italic = true },

   -- lua.
   ["@constructor.lua"] = { link = "Delimiter" },

   -- Asciidoc.
   ["asciidocAttributeEntry"] = { fg = fg.slate },
   ["asciidocAttributeList"]  = { fg = fg[3] },
   ["asciidocBlockTitle"]     = { fg = fg[4], italic = true },
   ["asciidocLineBreak"]      = { fg = fg.slate },
   ["asciidocListingBlock"]   = { fg = fg[3] },
   ["asciidocMacro"]          = { fg = fg.paynes },
   ["asciidocURL"]            = { link = "@string.special.url" },

   -- C
   ["@type.builtin.c"] = { fg = fg[3] },

   -- markup (misc.)
   ["@markup.bold"]       = { bold = true },
   ["@markup.heading"]    = { fg = fg[4]  },
   ["@markup.heading.1"]  = { fg = fg[4], bold = true },
   ["@markup.heading.2"]  = { fg = fg[4], bold = true },
   ["@markup.italic"]     = { italic = true },
   ["@markup.link.label"] = { link = "@string.special.url" },
   ["@markup.link.url"]   = { link = "@string.special.url" },
   ["@markup.list"]       = { link = "Delimiter" },
   ["@markup.raw"]        = { fg = fg[2] },
   ["@markup.strong"]     = { bold = true },

   -- Markdown specific
   -- Stops things like `vimdoc` from also having underlined top-level headings.
   ["@markup.heading.1.markdown"] = { fg = fg[4], bold = true, underline = true },

   -- Beancount.
   ["@markup.italic.beancount"] = { fg = fg[4], italic = true },

   --- Plugins -----------------------------------------------------------------
   -----------------------------------------------------------------------------

   -- nvim-treesitter-context
   TreesitterContext = { bg = bg[1] },

   -- lazy.nvim
   LazyNormal       = { bg = bg[0] },
   LazyButton       = { fg = fg[3], bg = bg[2] },
   LazyCommit       = { link = "Comment" },
   LazyCommitType   = { link = "Comment" },
   LazyH1           = { fg = fg[3] },
   LazyProp         = { fg = fg[2] },
   LazyReasonCmd    = { link = "Comment" },
   LazyReasonFt     = { link = "Comment" },
   LazyReasonPlugin = { fg = fg[3] },
   LazyReasonStart  = { link = "Normal" },
   LazySpecial      = { fg = fg[3] },

   MasonHighlight          = { fg = fg.paynes },
   MasonHighlightSecondary = { fg = fg.slate },
   MasonMutedBlock         = { fg = fg[3], bg = bg[2] },
   MasonHighlightBlockBold = { link = "Visual" },

   jjChanged = { fg = fg.slate },
   jjAdded   = { fg = fg[4]  },
   jjRemoved = { fg = fg.red   },
   --}}}

}) do
   vim.api.nvim_set_hl(0, name, highlight)
end

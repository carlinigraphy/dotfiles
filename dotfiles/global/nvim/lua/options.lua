local opt = vim.opt
local g   = vim.g

vim.cmd.colorscheme("paynes-greyscale")

-- Wondering if these should be set in colorscheme?
vim.cmd.set("t_Co=256")
opt.termguicolors  = true

-- Still playing around with this. It's not yet where I want it to be.
--opt.formatoptions  = 'croqnj'

-- Alphabetized opts. Ones requiring more commented explanations are found in
-- the subsequent section.
opt.backspace      = { "indent", "eol", "start" }
opt.breakindent    = true
opt.breakindent    = true
opt.breakindentopt = "sbr"
opt.completeopt    = {
   "menu",
   "menuone",
   "popup",
   "noselect"
}
opt.cursorline     = false
opt.cursorlineopt  = "number"
opt.diffopt        = {
   "internal",
   "filler",
   "closeoff",
   "iwhite",
   "icase",
   "linematch:60",
   "algorithm:minimal"
}
opt.expandtab      = true
opt.expandtab      = true
opt.fillchars      = { fold = " ", vert = "│", diff = "╲" }
opt.hidden         = true
opt.hlsearch       = false
opt.ignorecase     = true
opt.inccommand     = "split"
opt.joinspaces     = false
opt.joinspaces     = false
opt.list           = false
opt.listchars      = {
   tab = "▏ ",
   trail = "·",
   extends = "»",
   precedes = "«",
}
opt.mouse          = ""
opt.number         = true
opt.pumheight      = 20
opt.relativenumber = true
opt.scrolloff      = 3
opt.shiftround     = true
opt.shiftwidth     = 3
--opt.shortmess:append("c") -- remove messages for insertion completion
opt.signcolumn     = "auto"
opt.smartcase      = true
opt.softtabstop    = 3
opt.spelllang      = "en_us"
opt.splitbelow     = false
opt.splitright     = true
opt.tabstop        = 3
opt.undofile       = true
opt.virtualedit    = "block"
opt.wildmenu       = true
opt.wildmode       = { "longest", "full" }
opt.wildoptions    = { "pum" } -- want to like 'fuzzy', but doesn't fit my use

g.netrw_keepdir  = 0
g.netrw_winsize  = -40

-- Highlight on yank. Iunno. Kinda good visual confirmation I guess.
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("YankHighlight", { clear = true })
autocmd("TextYankPost",  {
   group    = "YankHighlight",
   callback = function()
      vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
   end
})

-- Preview window annoyingly stays open after completion is completed.
autocmd("CompleteDone", {
   pattern = "*",
   callback = function()
      vim.cmd.pclose()
   end,
})

-- No line numbers in terminal.
autocmd("TermOpen", {
   pattern = "*",
   callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
   end
})

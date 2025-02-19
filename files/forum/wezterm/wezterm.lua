local term = require("wezterm")

local config = {
   -- Regular "static" options can just be dropped here directly.
   enable_tab_bar = false,
   quick_select_alphabet = "fjdksla;",
   initial_rows = 10,
   initial_cols = 40,
}

config.warn_about_missing_glyphs = false
config.line_height = 1.15
config.font_size = 8.5
config.font = term.font_with_fallback({
   -- ref. https://wezfurlong.org/wezterm/config/lua/wezterm/font.html
   {  family = "Aurelius Round",
      weight = "Regular",
      stretch = "Normal",
   },
   "Symbols Nerd Font Mono", --< just for sudo lock icon in prompt
   "Font Awesome 6 Brands Regular",
   "Font Awesome 6 Free Regular",
   "Font Awesome 6 Free Solid",
})

-- Disable ligatures.
-- Woo! Finally free of that garbage.
config.harfbuzz_features = {
      'calt=0',
      'clig=0',
      'liga=0'
}

config.colors = {
   background = "#121212",
   foreground = "#d0d0d0",

   cursor_bg     = "d0d0d0",
   cursor_fg     = "black",
   cursor_border = "#f0a96e",

   ansi = {
      "#404040",  -- black
      "#ae6878",  -- red
      "#709090",  -- green
      "#cba381",  -- yellow
      "#708090",  -- blue     ::  slate
      "#909090",  -- magenta  ::  mid-grey
      "#d0d0d0",  -- cyan     ::  light-grey
      "#ffffff",  -- white
   },

   brights = {
      "#404040",  -- black
      "#9b4a6b",  -- red
      "#709090",  -- green
      "#cba381",  -- yellow
      "#708090",  -- blue
      "#909090",  -- magenta
      "#d0d0d0",  -- cyan
      "#ffffff",  -- white
   },

   selection_fg = 'black',
   selection_bg = '#fffacd',

   quick_select_label_bg = { Color = '#000000' },
   quick_select_label_fg = { Color = '#f0a96e' },
   quick_select_match_bg = { Color = '#000000' },
   quick_select_match_fg = { Color = '#ffffff' },
}

return config

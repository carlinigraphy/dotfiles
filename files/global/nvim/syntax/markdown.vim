" This file isn't loaded if I'm using tree-sitter markdown highlights. Think
" modifications need to be done via a query file.

syn match Comment /\v^─+$/    " Horizontal rule, used in pop-up documentation
syn region Comment start="<!--" end="-->"

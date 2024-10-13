"setlocal spell
"" Little annoying to get all the capitalization warnings when doing
"" non-sentence practice.

setlocal scrollbind
setlocal nosmartindent
setlocal noautoindent
setlocal textwidth=72
setlocal scrolloff=-1

inoremap <buffer> kj   ┐<CR>
inoremap <buffer> jk   │<CR>
inoremap <buffer> jk   │<CR>

inoremap <buffer> <C-e> <C-o>5<C-e>
inoremap <buffer> <C-y> <C-o>5<C-y>

" These lines have intentional trailing spaces.
inoremap <buffer> :re REVIEW:: 
inoremap <buffer> :er ERROR:: 

" Horizontal rule.
inoremap <buffer> :hr <C-o>72a─<C-[>A

nnoremap <buffer> <leader>fe :vimgrep /\v(ERROR\|REVIEW)::/ %<CR>

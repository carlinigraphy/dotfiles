" Easier to `:cc $COUNT` without relative numbers.
setl number norelativenumber

" Compiler errors are often long. This makes them a bit easier to fit onto one
" screen.
setl wrap linebreak
setl showbreak=\\
setl breakat-=- " Don't line-break on dashes

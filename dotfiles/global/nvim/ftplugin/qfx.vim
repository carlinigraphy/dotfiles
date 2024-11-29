" Update: I don't think this should be necessary, as flattening is largely as
" simple as doing:
"     :%s,>,>\r,g

" When trying to play with unformatted qfx files, it positively cannot
" understand how to indent things.
"setlocal noautoindent nosmartindent indentexpr=

" Tricked ya, it was just xml this whole time.
"setlocal filetype=xml

"set conceallevel=2
"syn match nroffEmptyLine /^\.$/ conceal
" This is why it needs to be in after/. Can't seemingly define new matches
" otherwise.

syn match nroffComment /^\.$/
" Rather than concealing, just make it very dim. It is useful to be aware of
" the presence of a leading period.

hi link nroffReqLeader Paynes1
hi link nroffReqName   Boolean
hi link nroffEscape    Comment
hi link nroffEscRegArg Special

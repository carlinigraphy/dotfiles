" Box drawing chars can't count as keywords. Gotta match as 
syn match stenoTranslationBox       "[┐│]"
syn match stenoTranslationHr        "\v^─+$" 

syn match stenoTranslationQuestion  "\v^\s*Q\.\s+"
syn match stenoTranslationAnswer    "\v^\s*A\.\s+"

syn match stenoTranslationReview    "REVIEW::"   contains=stenoTranslationColon
syn match stenoTranslationError     "ERROR::"    contains=stenoTranslationColon
syn region stenoTranslationNote     start="::"  end="\n"  contained containedin=stenoTranslationReview,stenoTranslationError

hi! def link stenoTranslationReview  WarningMsg
hi! def link stenoTranslationError   ErrorMsg
hi! def link stenoTranslationNote    Comment
hi! def link stenoTranslationColon   Comment
hi! def link stenoTranslationBox     Comment
hi! def link stenoTranslationHr      Comment

hi! def link stenoTranslationQuestion    Conditional
hi! def link stenoTranslationAnswer      Conditional

if exists("b:current_syntax")
  finish
endif
let b:current_syntax = "goldsrctitlestxt"

setlocal commentstring=//\ %s
setlocal iskeyword+=$

syntax keyword goldsrcTitlesTXTProperty $position $effect $fadein $fxtime $holdtime $fadeout $color $color2
syntax region goldsrcTitlesTXTComment start="//" end="$"
syntax region goldsrcTitlesTXTMessage start="{\zs" end="\ze}"
syntax match goldsrcTitlesTXTMessageEnd "}" contained
syntax match goldsrcTitlesTXTMessageStart "{" contained

syntax match goldsrcTitlesTXTNumeric "\v[0-9]+(\.\d+)?"
syntax match goldsrcTitlesTXTMessageName "\v^.*\n\@=\ze\{"
syntax match goldsrcTitlesTXTSentenceNameTooLong "\v^!.{16,}\n\@=\ze\{"

highlight default link goldsrcTitlesTXTComment Comment
highlight default link goldsrcTitlesTXTMessage String
highlight default link goldsrcTitlesTXTMessageEnd Delimiter
highlight default link goldsrcTitlesTXTMessageStart Delimiter
highlight default link goldsrcTitlesTXTProperty Identifier
highlight default link goldsrcTitlesTXTMessageName Title
highlight default link goldsrcTitlesTXTSentenceNameTooLong Error
highlight default link goldsrcTitlesTXTNumeric Number

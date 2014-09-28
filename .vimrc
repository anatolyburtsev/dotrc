set tabstop=4 
set shiftwidth=4 
set expandtab
syntax on
let python_highlight_all = 1
" быстрая помощь по данной питонячей функции по K в normal mode
setlocal keywordprg=pydoc
" искать в pwd+поддиректориях http://www.allaboutvim.ru/2012/03/path.html
set path=.,,**
"время 
function! CurTime()
  let ftime=""
  let ftime=ftime." ".strftime("%H:%M:%S")
  return ftime
endfunction

" size
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "K"
    endif
endfunction

"define 3 custom highlight groups
hi User1 ctermbg=black  ctermfg=darkblue   guibg=green guifg=red
hi User2 ctermbg=black  ctermfg=darkred  guibg=red   guifg=red
hi User3 ctermbg=black  ctermfg=yellow guibg=blue  guifg=green

"статусная строка внизу справа
" Всегда показывать строку статуса
set laststatus=2
set noruler   
" custom statusline
set statusline=%3*              "switch to User3 highlight
set statusline+=%-.100F,        "full path to filename
set statusline+=%m              "modified flag
set statusline+=%r\             "read only flag
set statusline+=%l/%L           "cursor line/total lines
set statusline+=\ %P            "percent through file

set statusline+=%=              "left/right separator
set statusline+=%2*              "switch to User2 highlight
set statusline+=%{CurTime()}\   "time
set statusline+=%1*              "switch to User1 highlight
set statusline+=%y,             "filetype
set statusline+=%{FileSize()},  "filesize
set statusline+=%{&encoding}    "current encoding


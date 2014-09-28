set tabstop=4 
set shiftwidth=4 
set expandtab
syntax on
" искать в pwd+поддиректориях http://www.allaboutvim.ru/2012/03/path.html
set path=.,,**

"время 
fun! CurTime()
  let ftime=""
  let ftime=ftime." ".strftime("%H:%M:%S")
  return ftime
endf

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
hi User1 ctermbg=green ctermfg=red   guibg=green guifg=red
hi User2 ctermbg=red   ctermfg=blue  guibg=red   guifg=blue
hi User3 ctermbg=black  ctermfg=yellow guibg=blue  guifg=green

"статусная строка внизу справа
" Всегда показывать строку статуса
set laststatus=2
set noruler   
"set statusline=%<%1*%f%h%m%r,%l,%c\ %P,%=\ %t,%{&ff},%2*%{&encoding}
set statusline=%3*  "switch to User1 highlight
"set statusline+=%t,        "tail of the filename
set statusline+=%-.100F,        "full path to filename
"set stat sline+=%f,       "tail of the filename
set statusline+=%m       "modified flag
set statusline+=%r\        "read only flag
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

set statusline+=%=      "left/right separator
set statusline+=%y,      "filetype
set statusline+=%{FileSize()},      "filesize
set statusline+=%{&encoding} 


let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

function! SetFontSize(amount)
  let s:fontsize = a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction

if has("win32")
    nnoremap <c-z> <nop>
endif

noremap <silent> <C-=> :call AdjustFontSize(1)<CR><c-w>=
noremap <silent> <C--> :call AdjustFontSize(-1)<CR><c-w>=
inoremap <silent> <C-+> <Esc>:call AdjustFontSize(1)<CR><c-w>=a
inoremap <silent> <C--> <Esc>:call AdjustFontSize(-1)<CR><c-w>=a
inoremap <silent> <C-0> <Esc>:call SetFontSize(10)<cr><c-w>=a
nnoremap <silent> <C-0> :call SetFontSize(10)<cr><c-w>=
" autocmd BufEnter,BufRead,BufNewFile *.lua :bufdo lua vim.diagnostic.disable()<cr>
" " Terminal Buffer
"
function! TerminalSettings()
    setlocal nonumber
    setlocal norelativenumber
    normal a
endfunction

" TermOpen is an event
autocmd TermOpen * call TerminalSettings()
autocmd BufRead,BufNewFile *.h set filetype=c

let g:ale_linters = {
\   'c': ['cc'],
\   'lua': [],
\}

function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

set colorcolumn=80

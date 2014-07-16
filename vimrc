execute pathogen#infect('plugins/{}')

" Autoreload this file.
augroup reload_vimrc {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END }

" Use syntax highlighting
syntax on

" Set theme
color twilight

" Autoindent
filetype plugin indent on

" Better line continuation indicator
set showbreak=⇇

" Show line numbers
set number

" Never enter Ex mode
nnoremap Q <nop>

" Whitespace settings
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" Removes trailing spaces
function! TrimWhiteSpace()
  %s/\s\+$//e
endfunction
nnoremap <silent> <Leader>rts :call TrimWhiteSpace()<CR>

" Applies whitespace trims on write
autocmd FileWritePre    * :call TrimWhiteSpace()
autocmd FileAppendPre   * :call TrimWhiteSpace()
autocmd FilterWritePre  * :call TrimWhiteSpace()
autocmd BufWritePre     * :call TrimWhiteSpace()

" Spellcheck on Git commits
autocmd FileType gitcommit setlocal spell

" Use some meta+function key codes to
" make special key combos work in terminal

map  <S-F1> <S-CR>
map! <S-F1> <S-CR>

" Bind shift-enter to esc
inoremap <S-CR> <Esc>
vnoremap <S-CR> <Esc>
cnoremap <S-CR> <Esc>
nnoremap <S-CR> <Esc>

" Reduce number of hit-enter prompts
set cmdheight=2
set shortmess=aoOtI

" NerdTree shortcuts
map <silent> <C-t> :NERDTreeToggle<CR>

" Single character insert
function! InsertSingle()
  sleep 240m|let l:a = getchar(0)
  if l:a != 0
    silent! exec "normal a" . nr2char(l:a)
  else
    silent! exec "normal a "
  endif
endfunction
nnoremap <silent> <Space> :call InsertSingle()<CR>

" Dynamic ruby evaulation bindings
" autocmd FileType ruby nmap <buffer> <C-,> <Plug>(xmpfilter-mark)
" autocmd FileType ruby xmap <buffer> <C-,> <Plug>(xmpfilter-mark)
" autocmd FileType ruby imap <buffer> <C-,> <Plug>(xmpfilter-mark)
"
" autocmd FileType ruby nmap <buffer> <C-.> <Plug>(xmpfilter-run)
" autocmd FileType ruby xmap <buffer> <C-.> <Plug>(xmpfilter-run)
" autocmd FileType ruby imap <buffer> <C-.> <Plug>(xmpfilter-run)

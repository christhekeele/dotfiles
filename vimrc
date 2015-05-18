execute pathogen#infect('plugins/{}')

set nocompatible

" Autoreload this file.
augroup reload_vimrc {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END }

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" move through wrapped lines
nnoremap j gj
nnoremap k gk

" Use Q for formatting the current paragraph (or selection)
vmap Q gq
nmap Q gqap

set shiftwidth=2  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set smarttab      " insert tabs on the start of a
                  "    line according to
                  "    shiftwidth, not tabstop

" Don't use vim backup utils
set nobackup
set noswapfile

set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Use syntax highlighting
syntax on

" Set theme
let g:hybrid_use_iTerm_colors = 1
colorscheme twilight

" Reevaluate buffer after type faster
set updatetime=1500

" Autoindent
filetype plugin indent on

" Better line continuation indicator
set showbreak=⇇

" Show line numbers
set number
" But relative numbers
set relativenumber
" Except when we lose focus
:au FocusLost * :set number
:au FocusGained * :set relativenumber
" Or in insert mode
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

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

" Bind ✠ (U+2720) to esc
"  so iTerm can emit it from shift-enter
"  during ssh vim sessions
inoremap ✠ <Esc>
vnoremap ✠ <Esc>
cnoremap ✠ <Esc>
nnoremap ✠ <Esc>

" Reduce number of hit-enter prompts
set cmdheight=2
set shortmess=aoOtI

" Enter commands with ;
nnoremap ; :
vnoremap ; :

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Sane buffer closing wilout killing window
command Bx bp|bd #

" GitGutter Background color
highlight clear SignColumn
" GitGutter signs
let g:gitgutter_sign_added = '❯❯'
let g:gitgutter_sign_modified = '❯❯'
let g:gitgutter_sign_removed = '❯❯'
let g:gitgutter_sign_removed_first_line = '❯❯'
let g:gitgutter_sign_modified_removed = '❯❯'
" GitGutter update times
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
au FocusLost * nested silent! wall
" GitGutter always there
let g:gitgutter_sign_column_always = 1
" GitGutter ignore whitespace`
let g:gitgutter_diff_args = '-w'

" Airline show buffers
let g:airline#extensions#tabline#enabled = 1
" Airline buffer seperators
"let g:airline#extensions#tabline#left_sep = '❯'
"let g:airline#extensions#tabline#left_alt_sep = '❱'
" show just the filename
"let g:airline#extensions#tabline#fnamemod = ':t'

" NERDTree shortcuts
map <silent> <C-t> :NERDTreeToggle<CR>
" NERDTree auto-open
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" NERDTree auto-close
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
let NERDTreeShowHidden=1

" Single character insert
function! InsertSingle()
  sleep 240m|let l:a = getchar(0)
  if l:a != 0
    silent! exec "normal i" . nr2char(l:a)
  else
    silent! exec "normal i "
  endif
endfunction
nnoremap <silent> <Space> :call InsertSingle()<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

set pastetoggle=<Ctrl-P>

" Dynamic ruby evaulation bindings
" autocmd FileType ruby nmap <buffer> <C-,> <Plug>(xmpfilter-mark)
" autocmd FileType ruby xmap <buffer> <C-,> <Plug>(xmpfilter-mark)
" autocmd FileType ruby imap <buffer> <C-,> <Plug>(xmpfilter-mark)
"
" autocmd FileType ruby nmap <buffer> <C-.> <Plug>(xmpfilter-run)
" autocmd FileType ruby xmap <buffer> <C-.> <Plug>(xmpfilter-run)
" autocmd FileType ruby imap <buffer> <C-.> <Plug>(xmpfilter-run)

" Recognize markdown better
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

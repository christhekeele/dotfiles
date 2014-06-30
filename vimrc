call pathogen#infect('plugins/{}')

" Autoreload this file.
augroup reload_vimrc " {
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Use syntax highlighting
syntax on

" Set theme
color twilight

" Autoindent
filetype plugin indent on

" Better line continuation indicator
set showbreak=↪

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

" Spellcheck on Git commits.
autocmd FileType gitcommit setlocal spell

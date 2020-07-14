let mapleader=" "
"let maplocalleader="-"

" Escape insert mode by pressing 'jk'
inoremap jk <esc>

nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>

nnoremap <leader>r :source $MYVIMRC<CR>

" More quickly call external programs
nnoremap <leader>> :!<space>

" Copy/Paste from register
vnoremap <leader>cc "*y
noremap <leader>vv "*p

" Copy and paste a line below the current line
noremap - ddp

" Delete a line in insert mode
inoremap <c-d> <esc>ddi

" Switch case on a word in insert mode
inoremap <c-u> <esc>viw~i

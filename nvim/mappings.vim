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

cnoremap %% <C-R>=fnameescape(expand("%:h"))."/"<CR>


"""""""""""""""""""""""""""""""""""""""""
"----------------Splits------------------
"""""""""""""""""""""""""""""""""""""""""

" Change splits navigation to Ctrl + <hjkl>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Adjust split size
nnoremap <silent> <C-Left> :vertical resize +3<CR>
nnoremap <silent> <C-Right> :vertical resize -3<CR>
nnoremap <silent> <C-Up> :resize +3<CR>
nnoremap <silent> <C-Left> :resize -3<CR>

" Change split orientation
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K


"""""""""""""""""""""""""""""""""""""""""""
" -------------- NERDtree -----------------
"""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent><leader>\ :NERDTreeToggle<CR>
nnoremap <silent><leader>p :CtrlP<CR>
nnoremap <silent><leader>b :CtrlPBuffer<CR>

packadd minpac

call minpac#init()

call minpac#add('k-takata/minpac', {'type': 'opt'})

"----------------------- Core Plugins ----------------------

" Utility
call minpac#add('yuttie/comfortable-motion.vim')    " Scrolling
call minpac#add('christoomey/vim-tmux-navigator')   " Navigation between vim and tmux splits

" Status and UI
call minpac#add('itchyny/lightline.vim')

"-------------------------- Themes -------------------------
"
call minpac#add('sainnhe/lightline_foobar.vim', { 'type': 'opt' })

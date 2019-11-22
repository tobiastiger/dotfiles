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

call minpac#add('challenger-deep-theme/vim', { 'name': 'challenger-deep' })
call minpac#add('ayu-theme/ayu-vim', {'type': 'opt'})
call minpac#add('drewtempelmeyer/palenight.vim', {'type': 'opt'})
call minpac#add('arcticicestudio/nord-vim', {'type': 'opt'})
call minpac#add('dracula/vim', {'type': 'opt', 'name': 'dracula'})
call minpac#add('sainnhe/lightline_foobar.vim', { 'type': 'opt' })
call minpac#add('rakr/vim-two-firewatch', { 'type': 'opt' })

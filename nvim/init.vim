"""""""""""
"" Plugins 
"""""""""""
call plug#begin('~/.vim/plugged')
Plug 'fatih/vim-go'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } 
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
call plug#end()

"""""""""""
"" Source
"""""""""""
source ~/.config/nvim/theme.vim
source ~/.config/nvim/coc.vim

"""""""""""
"" Settings
"""""""""""
set tabstop=4
set shiftwidth=4

nnoremap <C-p> :GFiles<CR>

"""""""""""
"" Aliases
"""""""""""

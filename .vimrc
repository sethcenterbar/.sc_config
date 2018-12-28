call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mbbill/undotree'
Plug 'PProvost/vim-ps1'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'junegunn/goyo.vim'
Plug 'saltstack/salt-vim'
Plug 'hhsnopek/vim-firewatch'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

colorscheme firewatch

" airline 
let g:lightline = {
  \ 'colorscheme': 'bubblegum',
  \ }
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

" for html/rb files, 2 spaces
autocmd Filetype python3 setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=2 sw=2 expandtab

" salt-vim
syntax on
set nocompatible
filetype plugin indent on

" Custom mapping
cnoreabbrev nt NERDTreeToggle
:nnoremap <leader>w <c-w>
:nnoremap <leader>t :NERDTreeToggle<cr>
:nnoremap <leader>g :Goyo<cr>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

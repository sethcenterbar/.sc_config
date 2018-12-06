call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mbbill/undotree'
Plug 'PProvost/vim-ps1'
Plug 'ConradIrwin/vim-bracketed-paste'
Plug 'davidhalter/jedi-vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-commentary'
call plug#end()

colorscheme apprentice

" by default, the indent is 2 spaces.
set shiftwidth=2
set softtabstop=2
set tabstop=2
set number

" for html/rb files, 2 spaces
autocmd Filetype python3 setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=2 sw=2 expandtab

" Custom mapping
cnoreabbrev nt NERDTreeToggle
:nnoremap <leader>w <c-w>
:nnoremap <leader>t :NERDTreeToggle<cr>
nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<cr>

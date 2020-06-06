" --- " Plugin management " --- "
call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'itchyny/lightline.vim'
Plug 'https://github.com/ap/vim-css-color.git'
Plug 'preservim/NerdTREE'
call plug#end()

" --- " Basic Settings " --- "
set number relativenumber
syntax on
set encoding=utf-8
set fileencoding=utf-8
set noshowmode
set laststatus=2
set incsearch
set hlsearch

" --- " Remaps " --- "
imap jk <Esc>

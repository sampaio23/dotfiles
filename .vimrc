" --- " Basic Settings " --- "

set number
set mouse=a
syntax on
set nocompatible
set nocompatible
behave mswin

" --- " Key Maps " --- "

imap jk <Esc>

" Save
imap <C-s> <Esc>:w<CR>
nmap <C-s> :w<CR>

" Undo and redo
imap <C-z> <Esc>:u<CR>i
nmap <C-z> :u<CR>

imap <C-y> <Esc><C-R>i
nmap <C-y> <C-R>

" Copy, paste and cut

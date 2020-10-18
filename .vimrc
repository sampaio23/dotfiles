" --- " Plugin management " --- "
call plug#begin()
Plug 'junegunn/goyo.vim'
Plug 'https://github.com/itchyny/lightline.vim'
Plug 'preservim/NerdTREE'
Plug 'chrisbra/Colorizer'
Plug 'pangloss/vim-javascript' 
Plug 'easymotion/vim-easymotion'
"Plug 'ajh17/VimCompletesMe'
Plug 'ycm-core/YouCompleteMe'
Plug 'alvan/vim-closetag'
"Plug 'dense-analysis/ale'
"Plug 'Yggdroot/indentLine'
"Plug 'ryanoasis/vim-devicons'
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
set splitbelow
set splitright
let g:colorizer_auto_filetype='css,html'
hi LineNr ctermfg=gray
hi CursorLineNR cterm=bold ctermbg=NONE ctermfg=yellow
hi CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE
set cursorline

" --- " Identation " --- "
set nocindent
set nosmartindent
set noautoindent
set indentexpr=
filetype indent off
filetype plugin indent off
set expandtab
set tabstop=2
set shiftwidth=2

" --- " Remaps " --- "
imap jk <Esc>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" --- " NERDTree " --- "
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeQuitOnOpen = 1

" --- " Cursor " --- "
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" --- " Mapping and key code delays " --- "
set timeoutlen=1000 
set ttimeoutlen=0

map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" --- " Folds " --- "
"augroup remember_folds
"  autocmd!
"  autocmd BufWinLeave ?* mkview | filetype detect
"  autocmd BufWinEnter ?* silent loadview | filetype detect
"augroup END

" --- " Autocomplete Colors " --- "
highlight Pmenu ctermfg=15 ctermbg=233
highlight Pmenusel ctermfg=16 ctermbg=250

" --- " LaTeX Shortcuts" --- "
let g:tex_flavor = 'tex'
inoremap ;<Space> <Esc>/<++><Enter>"_c4l<Esc>:noh<Enter>a

autocmd FileType tex inoremap ;bf \textbf{}<Space><++><Esc>T{i
autocmd FileType tex inoremap ;it \textit{}<Space><++><Esc>T{i

autocmd FileType tex inoremap ;ul \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap ;t \begin{tabular}<Enter><++><Enter>\end{tabular}<Enter><Enter><++><Esc>4kA{}<Esc>i
autocmd FileType tex inoremap ;eq $$<Enter><Enter>$$<Enter><Enter><++><Esc>3kA
autocmd FileType tex inoremap ;sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap ;fig \begin{figure}[H]<Enter>\centering<Enter>\includegraphics[scale=1]{}<Enter>\caption{<++>}<Enter>\label{<++>}<Enter>\end{figure}<Enter><Enter><++><Esc>5k$i

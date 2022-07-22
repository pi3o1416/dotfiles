call plug#begin('~/.local/share/nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'SirVer/ultisnips'
Plug 'neomake/neomake'
Plug 'honza/vim-snippets'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'


call plug#end()


"custom settings

let g:python3_host_prog="/usr/bin/python"
let mapleader = ","
set nocompatible
set number		
set relativenumber
set cursorline
set guicursor=

set tabstop=4
set shiftwidth=4
set expandtab

let g:indentLine_char = '.'


"setup for ctrlp
let g:ctrlp_working_path_mode = 'aw'



"setup for deoplete
"let g:deoplete#enable_at_startup = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif



"setup for vim-colors-solarized
syntax enable
set background=light
colorscheme solarized8_high
let g:solarized_termcolors=256



"setup for gruvbox
"syntax enable
"set background=light
"colorscheme gruvbox
"let g:gruvbox_contrast_dark  = "light"



"setup for papercolor
"set t_Co=256
"set background=dark
"colorscheme PaperColor




"setup for ultisnips
let g:UltiSnipsExpandTrigger       = "<c-d>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
let g:UltiSnipsListSnippets        = "<c-?>" "List possible snippets based on current file"


"setup for delimitmate
let delimitMate_expand_space = 1
let delimitMateBackspace = 1
autocmd filetype htmldjango let b:delimitMate_matchpairs = "(:),[:],<:>"


"set up NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif


"set up Neomake
let g:neomake_python_enabled_makers = ['flake8']


"setup Coc
nnoremap <leader><C-f> :call CocAction('format')<cr>


"my keybindings
nnoremap <F3> :noh<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>j :+10<cr>
nnoremap <leader>k :-10<cr>
nnoremap <leader>sc :Neomake<cr>
nmap <leader>n :lnext<cr>
nmap <leader>m :lprev<cr>
autocmd filetype scss nnoremap <F5> :w <bar>!node-sass -o css %<cr>
autocmd filetype python nnoremap <F5> :w <bar>make py<cr>
autocmd filetype python nnoremap <F9> :w <bar>!python %<cr>
autocmd filetype html nnoremap <leader>n :setfiletype htmldjango<cr>
autocmd FileType cpp nnoremap <F9> :w !clear <bar>make<cr>
autocmd FileType cpp nnoremap <F5> :!./%:r<cr>
autocmd FileType c nnoremap <F5> :!./%:r<cr>
autocmd filetype dart nnoremap <F9> :w <bar>!dart %<cr>
nnoremap <F6> :silent !clear <Enter>

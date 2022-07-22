let mapleader = ","
set nocompatible            " be iMproved, required
set relativenumber          " show relative number top to bottom
set title                   " show title top of terminal
set clipboard=unnamedplus
set encoding=utf-8
filetype off                " required
helptags ~/.vim/doc
filetype plugin on

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'


Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'rafi/awesome-vim-colorschemes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'SirVer/ultisnips'
"dart language support
Plugin 'dart-lang/dart-vim-plugin'
Plugin 'natebosch/vim-lsc'
Plugin 'natebosch/vim-lsc-dart'



" Optional:
Plugin 'honza/vim-snippets'



call vundle#end()            " required
filetype plugin indent on    " required


" custom setting
set mouse=a
set number
set encoding=utf-8
set backspace=indent,eol,start
set cursorline
set guioptions=
syntax on


" indent for global
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent



" indent for special file


autocmd FileType c,cpp setlocal expandtab shiftwidth=4 softtabstop=4 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent


"set up for solarized
"set background=light
"colorscheme flattened_dark


" setup for gruvbox
"set t_Co=256
set background=light
colorscheme gruvbox
let g:gruvbox_contrast_dark  = 'hard'


" tender
" termschool
" solarized8
" abstract
" deus
"


"Highlight color for search
"F3
set hlsearch                    
hi Search ctermbg = LightYellow
hi Search ctermfg = Red



" vim-dart-plugin
let g:dart_style_guide = 4




"set up for ultisnips
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file"



 
"setup for delimitmate
let delimitMate_expand_space = 1
let delimitMateBackspace = 1
autocmd filetype htmldjango let b:delimitMate_matchpairs = "(:),[:],<:>"




"set up NERDTree
map <C-n> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif



"vim keybinding
"
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>j :+10<cr>
nnoremap <leader>k :-10<cr>
nnoremap <leader>pf :SyntasticCheck flake8<cr>
nnoremap <leader>pp :SyntasticCheck pylint<cr>
nnoremap <leader>cc :SyntasticCheck cppcheck<cr>
autocmd filetype python nnoremap <F9> :w <bar>!python %<cr>
autocmd filetype python nnoremap <F5> :w <bar>make py<cr>
autocmd filetype html nnoremap <leader>m :setfiletype htmldjango<cr>
autocmd FileType cpp nnoremap <F9> :w !clear <bar>make<cr>
autocmd FileType cpp nnoremap <F5> :!./%:r<cr>
autocmd FileType c nnoremap <F5> :!./%:r<cr>
autocmd filetype dart nnoremap <F9> :w <bar>!dart %<cr>
nnoremap <F6> :silent !clear <Enter>
nnoremap <F3> :noh<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprevious<CR>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Raimondi/delimitMate'
Plug 'hashivim/vim-terraform'
Plug 'vim-airline/vim-airline'
Plug 'justinj/vim-react-snippets'
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
Plug 'jidn/vim-dbml'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'


call plug#end()


"custom settings

let g:python3_host_prog="/usr/bin/python"
let mapleader = ","
set nocompatible
set number		
set relativenumber
set cursorline
set guicursor=

" by default, the indent is 2 spaces. 
set shiftwidth=2
set softtabstop=2
set tabstop=2

" for html/rb files, 2 spaces
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype typescript setlocal ts=2 sw=2 expandtab
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype css setlocal ts=2 sw=2 expandtab
autocmd Filetype markdown setlocal ts=2 sw=2 expandtab

" for js/coffee/jade files, 4 spaces
autocmd Filetype python setlocal ts=4 sw=4 sts=0 expandtab

let g:indentLine_char = '.'


"setup for ctrlp
let g:ctrlp_working_path_mode = 'aw'



"setup for deoplete
"let g:deoplete#enable_at_startup = 1
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif



"setup for vim-colors-solarized
"syntax enable
"set background=light
"colorscheme solarized
"let g:solarized_termcolors=256



"setup for gruvbox
syntax enable
set background=light
let g:gruvbox_contrast_dark  = "soft"
let g:gruvbox_contrast_light  = "medium"
colorscheme gruvbox



"setup for papercolor
"set t_Co=256
"set background=dark
"colorscheme PaperColor


"setup for editorconfig
let g:EditorConfig_exclude_patterns = ['fugitive://.*']
let g:EditorConfig_exclude_patterns = ['scp://.*']



"setup for ultisnips
let g:UltiSnipsExpandTrigger       = "<c-s>"
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

"setup for jsx
let g:jsx_ext_required = 0 


"set up Neomake
let g:neomake_python_enabled_makers = ['flake8']


"setup Coc
nnoremap <leader><C-f> :call CocAction('format')<cr>
if has('nvim-0.4.0') || has('patch-8.2.0750')
	nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
	inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
	inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
	vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
	vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

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


" Terraform
autocmd BufRead,BufNewFile *.tf set filetype=hcl
autocmd BufRead,BufNewFile *.hcl set filetype=hcl
autocmd BufRead,BufNewFile .terraformrc,terraform.rc set filetype=hcl
autocmd BufRead,BufNewFile *.tf,*.tfvars set filetype=terraform
autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json

let g:terraform_fmt_on_save = 1
let g:terraform_align = 1

nnoremap <leader>ti :!terraform init<CR>
nnoremap <leader>tv :!terraform validate<CR>
nnoremap <leader>tp :!terraform plan<CR>
nnoremap <leader>taa :!terraform apply -auto-approve<CR>

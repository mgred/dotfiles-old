" Enable syntax processing
syntax on

" Set number of visual spaces per tab
set tabstop=4

" Set number of tabs while editing
set softtabstop=4

" Set number of columns for indent
set shiftwidth=4

" Show line numbers
set number

" Load filteype specific ident files
filetype indent on

" Show current mode down the bottom
set showmode

" Always report # of lines changed
set report=0

" Use utf8 by default
set encoding=utf-8

" Always display status line
set laststatus=2

" Highlight the current line
set cursorline

" Set a colored column after 80 characters
 set colorcolumn=80

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Turn on the Wild menu
set wildmenu

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

set listchars=eol:¬,tab:➜\ ,space:⋅

set list

" Turn off compatibility with vi
set nocompatible
filetype off

call plug#begin('~/.vim/plugged')


" Start of plugin list

" Lightline
" https://github.com/itchyny/lightline.vim

Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

" Highlight trailing space
" https://github.com/bronson/vim-trailing-whitespace
Plug 'bronson/vim-trailing-whitespace'

" JavaScript syntax highlighting
" https://github.com/othree/yajs.vim
Plug 'othree/yajs.vim'

" surround.vim
" https://github.com/tpope/vim-surround
Plug 'tpope/vim-surround'

" Fugitive plugin
" https://github.com/tpope/vim-fugitive
Plug 'tpope/vim-fugitive'

Plug 'junegunn/gv.vim'

" Add plugins to &runtimepath
call plug#end()

" colorscheme options
let g:sierra_Twilight = 1
colorscheme sierra

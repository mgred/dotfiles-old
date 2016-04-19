"===============================================================================
"
"                       o88
"           oooo   oooo oooo  oo ooo oooo   oo oooooo     ooooooo
"            888   888   888   888 888 888   888    888 888     888
"         ooo 888 888    888   888 888 888   888        888
"         888   888     o888o o888o888o888o o888o         88ooo888
"
"                                Version : 0.1
"
"===============================================================================
" TABLE OF CONTENT
"===============================================================================
"
" # General
" # Remappings
" # Appearance
" # Behavior
" # Plugins
" ## Plugin options
"
"===============================================================================


"===============================================================================
" GENERAL
"===============================================================================

" Set the amount of lines to remember
set history=700

" Enable syntax processing
syntax on

" Turn off compatibility to vi
set nocompatible

filetype on

" Set number of visual spaces per tab
set tabstop=4

" Set number of tabs while editing
set softtabstop=4

" Set number of columns for indent
set shiftwidth=4

" Load filteype specific ident files
filetype indent on

"===============================================================================
" REMAPPINGS
"===============================================================================

" leader is comma
let mapleader=","

" jk is equal to ESC in insert mode
inoremap jk <esc>


"===============================================================================
" APPEARANCE
"===============================================================================

" Show current mode down the bottom
set showmode

" Always report # of lines changed
set report=0

" Always display status line
set laststatus=2

" Highlight the current line
set cursorline

" Set a colored column after 80 characters
set colorcolumn=80

" Show line numbers
set number

" Colorscheme
" https://github.com/AlessandroYorba/Sierra
let g:sierra_Twilight = 1
colorscheme sierra

" Use utf8 by default
set encoding=utf-8

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

set listchars=eol:¬,tab:➜\ ,space:⋅

set list

"===============================================================================
" BEHAVIOR
"===============================================================================

" Turn backup off
set nobackup
set nowb
set noswapfile

" Turn on the Wild menu
set wildmenu

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

"===============================================================================
" PLUGINS
"===============================================================================

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

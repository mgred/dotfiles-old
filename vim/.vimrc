syntax on

let mapleader = ";"

"highligh Normal ctermfg=236
"highligh ModeMsg ctermfg=236
"au CmdLineEnter * hi Normal ctermfg=white
"au CmdLineLeave * hi Normal ctermfg=236

set updatetime=100

" Disable Intro message
set shortmess=I

" Don't show the mode
set noshowmode 

" Don't create swap files
set noswapfile

" Set the charater used, when a vertical split is created
set fillchars+=vert:\│

" ESC with jk
imap jk <Esc>

function! ErrorStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))
	return (l:counts.error + l:counts.style_error) == 0 ? '' : '•'
endfunction

function! WarningStatus() abort
	let l:counts = ale#statusline#Count(bufnr(''))
	return (l:counts.warning + l:counts.style_warning) == 0 ? '' : '•'
endfunction

"
" Plugins
"
call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'

Plug 'airblade/vim-gitgutter'

Plug 'w0rp/ale'

Plug 'editorconfig/editorconfig-vim'

Plug 'sheerun/vim-polyglot'

Plug 'Quramy/tsuquyomi'

Plug 'altercation/vim-colors-solarized'

Plug 'scrooloose/nerdtree'

call plug#end()

" Colourscheme
set background=dark
colorscheme solarized

" Change cursor when opening & leaving vim,
" otherwise it would get the last from zsh
autocmd VimEnter * silent exec "! echo -ne '\e[1 q'"
autocmd VimLeave * silent exec "! echo -ne '\e[5 q'"

" Change cursor for modes
let &t_SI = "\e[5 q" " Insert mode, pipe
let &t_EI = "\e[1 q" " Normal/Visual mode, block
let &t_SR = "\e[3 q" " Replace mode, underlined

" Configure Statusline
set laststatus=2
set statusline= 
set statusline+=%1*%{ErrorStatus()}
set statusline+=%2*%{WarningStatus()}
set statusline+=%3*%{&modified\ ?'•':''}
set statusline+=%=
set statusline+=%t
set statusline+=\ 
set statusline+=%l
set statusline+=\/
set statusline+=%L

" User Colours red, yellow, gray
hi User1 ctermfg=1
hi User2 ctermfg=3
hi User3 ctermfg=10

hi StatusLine ctermbg=white ctermfg=8
hi StatusLineNC ctermbg=0 ctermfg=8
hi VertSplit ctermbg=8 ctermfg=0
" Set the fg color of the buffer char (default `~`)
" to the background color to hide them
hi EndOfBuffer ctermfg=8


let g:ale_sign_error = '×'
let g:ale_sign_warning = '×'
let g:gitgutter_enabled = 0
let g:gitgutter_sign_added = '|'
let g:gitgutter_sign_modified = '|'
let g:gitgutter_sign_removed = '|'
let g:gitgutter_sign_removed_first_line = '|'
let g:gitgutter_sign_modified_removed = '!'
let g:gitgutter_override_sign_column_highlight = 0
highlight SignColumn ctermbg=8
highlight ALEError ctermbg=none cterm=underline
highlight ALEWarning ctermbg=none cterm=underline
highlight ALEErrorSign ctermfg=1
highlight ALEWarningSign ctermfg=3
let g:ale_linters = {
\   'awk': ['gawk'],
\   'javascript': ['eslint'],
\   'typescript': ['tsserver'],
\}

function! FzyCommand(choice_command, vim_command)
	try
		let output = system(a:choice_command . " | fzy ")
	catch /Vim:Interrupt/
		" Swallow errors from ^C, allow redraw!  below
   	endtry
     	redraw!
       	if v:shell_error == 0 && !empty(output)
           exec a:vim_command . ' ' .  output
     	endif
endfunction

let g:find_file = 'ag . --silent -g ""'
let g:find_file_git = 'git ls-files'
let g:find_file_all = 'ag . --silent -a -U -g ""'

nnoremap <leader>w :w<cr>

nnoremap <leader>e :call FzyCommand(find_file_git, ":e")<cr>
nnoremap <leader>fe :call FzyCommand(find_file, ":e")<cr>
nnoremap <leader>ge :call FzyCommand(find_file_all, ":e")<cr>
nnoremap <leader>v :call FzyCommand(find_file_git, ":vs")<cr>
nnoremap <leader>fv :call FzyCommand("ag . --silent -g ''", ":vs")<cr> 
nnoremap <leader>gv :call FzyCommand("ag . --silent -g '' -a -U", ":vs")<cr>
nnoremap <leader>s :call FzyCommand(find_file_git, ":sp")<cr>
nnoremap <leader>fs :call FzyCommand("ag . --silent -g ''", ":sp")<cr>
nnoremap <leader>gs :call FzyCommand("ag . --silent -g '' -a -U", ":sp")<cr>

map <leader>j :NERDTreeToggle<CR>

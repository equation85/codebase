call pathogen#infect()

""" Solarize Settings
let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="high"


set modelines=1			" last lines in document sets vim mode
set nocompatible		" user vim defaults

"""""""""""""""""""""""""
" General
"""""""""""""""""""""""""
" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" With a map leader it's possible to do extra key combinations
let mapleader=","
let g:mapleader=","

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""
" Vim user interface
"""""""""""""""""""""""""
" Always show current position
set ruler

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Highlight search results
set hlsearch

" For regular expression turn magic on
set magic

" Show matching brackets when text indicator is over them
"set showmatch

set number				" show line numbers
set showcmd				" display incomplete commands

set ls=2				" always show status line
set title				" show title in console title bar
set ttyfast				" smoother changes

set fdm=marker

"""""""""""""""""""""""""
" Colors and Fonts
"""""""""""""""""""""""""
set background=dark
colorscheme solarized
"colorscheme ir_black
syntax on				" syntax highlighting
syntax enable

set encoding=utf-8		" 显示用编码
set fileencoding=utf-8			" 保存用编码
set fileencodings=utf-8,ucs-bom,gb18030,gb2312,cp936	" 如何解码

"""""""""""""""""""""""""
" Files, backups and undo
"""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc. anyway...
"set nobackup
"set nowb
"set noswapfile

""""""""""""""""""""""""""""""
" Text, tab and indent related
""""""""""""""""""""""""""""""
" Use space instead of tabs
set expandtab

" Be smart when using tabss
set smarttab

" 1 tab == 2 spaces
set shiftwidth=2
set tabstop=2

set softtabstop=2

" Auto indent
set autoindent

" Smart indent
set smartindent

set cindent

" Wrap lines
set wrap

"""""""""""""""""""""""""""""""""""""""""""
" Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohl<cr>

" Smart way to move between windows
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffer
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" Open a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
	set switchbuf=useopen,usetab,newtab
	set stal=2
catch
endtry

" Return to last edit position when opening files
autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\		exe "normal! g`\"" |
		\ endif
" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %1

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
"autocmd BufWrite *.coffee :call DeleteTrailingWS()

""""""""""""""""""""""""""""""
" Vim-r-plugin Settings
""""""""""""""""""""""""""""""
let g:vimrplugin_screenplugin=1
let g:vimrplugin_noscreenrc=1
let g:vimrplugin_underscore=0
let vimrplugin_buildwait=120
let vimrplugin_routmorecolors=1
let vimrplugin_notmuxconf=1

""""""""""""""""""""""""""""""
" Help functions
""""""""""""""""""""""""""""""
function! CmdLine(str)
	exe "menu Foo.Bar :" . a:str
	emenu Foo.Bar
	unmenu Foo
endfunction

function! VisualSelection(direction) range
	let l:saved_reg=@"
	execute "normal! vgvy"

	let l:pattern=escape(@", '\\/.*$^~[]')
	let l:pattern=substitute(l:pattern, "\n$", "", "")

	if a:direction=='b'
		execute "normal ?" . l:pattern . "^M"
	elseif a:direction=='gv'
		call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
	elseif a:direction=='replace'
		call CmdLine("%s" . '/'. l:pattern . '/')
	elseif a:direction=='f'
		execute "normal /" . l:pattern . "^M"
	endif

	let @/=l:pattern
	let @"=l:saved_reg
endfunction

" Return true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	en
	return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
	let l:currentBufNum=bufnr("%")
	let l:alternateBufNum=bufnr("#")

	if buflisted(l:alternateBufNum)
		buffer #
	else
		bnext
	endif

	if bufnr("%")==l:currentBufNum
		new
	endif

	if buflisted(l:currentBufNum)
		execute("bdelete! ".l:currentBufNum)
	endif
endfunction

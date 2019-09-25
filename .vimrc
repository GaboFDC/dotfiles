"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=7000

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Height of the command bar
set cmdheight=2

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Cursor line and column
set cul
set cuc

set ruler

" No intro and shot messages
set shortmess=atI

" Highlight search results and search on typing
set hlsearch
set incsearch

" Show command in bottom bar
set showcmd

" Mantiene 3 lineas encima y debajo del cursor
set scrolloff=4

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Redraw only when we need to.
set lazyredraw

" Set to auto read when a file is changed from the outside
set autoread

" Extra key for mapings
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab
"set et

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Line Numbers
set number
nmap <leader>n :set rnu!<CR>

set ai "Auto indent
set si "Smart indent
set nowrap "No Wrap lines

""""""""""""""""""""""""""""""
"  Moving, utils and others  "
""""""""""""""""""""""""""""""

" Remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
   \ if line("'\"") > 0 && line("'\"") <= line("$") |
   \   exe "normal! g`\"" |
   \ endif

" Remember info about open buffers on close
set viminfo^=%
set iskeyword+=_,$,@,%,#,-

" Format the status line
"set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set laststatus=2

" No comportarse como simple VI
set nocompatible

" Autocompletion commands
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

" Turn persistent undo on
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Useful mappings for managing tabs
map <leader>t :tabnew<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"markdown
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}   set filetype=mkd
au BufRead,BufNewFile *.{go}   set filetype=go
au BufRead,BufNewFile *.{js}   set filetype=javascript
"rkdown to HTML
nmap md :!~/.vim/markdown.pl % > %.html <CR><CR>
nmap fi :!firefox %.html & <CR><CR>
nmap \ \cc
vmap \ \cc

" YAML
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml "foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
set tw=90
highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

let python_highlight_all = 1
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1

" python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                        Ansible                                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.yml set filetype=yaml.ansible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-Plug
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Py pep8 ident
Plug 'vim-scripts/indentpython.vim'

" Awesome semantic completer for py and other
Plug 'valloric/youcompleteme'
"map <space>g :tab split \| YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_goto_buffer_command = 'split-or-existing-window'
map <leader>g :tab YcmCompleter GoToDefinitionElseDeclaration<CR>

Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_sh_checkers = ['bashate', 'sh']
let g:syntastic_python_checkers = ['pylint', 'flake8']
let g:syntastic_python_pylint_args = '--max-line-length=120 --disable=missing-docstring'
let g:syntastic_python_flake8_args = '--max-line-length=120'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1

"Plug 'nvie/vim-flake8'

Plug 'pearofducks/ansible-vim', { 'do': './UltiSnips/generate.sh' }

"Plug 'chriskempson/base16-vim'
Plug 'whatyouhide/vim-gotham'

" Initialize plugin system
call plug#end()

" Colors
"colorscheme base16-default-dark
"colorscheme gotham

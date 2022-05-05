"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"   Pau Juan Garcia 
"
" Version:
"   2.0 - 10/08/2020
"
" Sections:
"   => Plugings
"   => Plugin configuration
"   => Neovim configuration
"   => Colors and Fonts
"   => Files, backups and undo
"   => Text, tab and indent related
"   => Moving around, tabs, windows and buffers
"   => Status line
"   => Editing mappings
"   => Spell checking
"   => Misc
"   => Helper functions

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Initialize plugin system
" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Insert desired plugins
Plug 'tpope/vim-commentary'                     "Commenting code easily
Plug 'tpope/vim-sensible'                       "Sensible .vimrc settings
Plug 'tpope/vim-surround'                       "Edit tags and surroundings easily
Plug 'tpope/vim-repeat'                         "Enhancing the dot key for plugins
Plug 'tpope/vim-fugitive'                       "Awesome Git Wrapper
Plug 'tpope/vim-dispatch'                       "Run servers with Vim (needed for other plugins)
Plug 'tpope/vim-unimpaired'                     "Complementary pairs of mappings
Plug 'tpope/vim-sleuth'                         "Automatic indent related configuration
Plug 'scrooloose/nerdtree'                      "Explore filetrees nicely
Plug 'itchyny/lightline.vim'                    "Practical and light status line
Plug 'ervandew/supertab'                        "Autocompletion using tab
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'                         "Awesome fuzzy file finder
Plug 'scrooloose/syntastic'                     "Syntax checking
Plug 'arcticicestudio/nord-vim'                 "Nice cool colorscheme
Plug 'jiangmiao/auto-pairs'                     "Insert or delete brackets, parens, quotes in pairs
Plug 'majutsushi/tagbar'                        "Vim plugin that displays tags in a window, ordered by scope
Plug 'davidhalter/jedi-vim'                     "Autocompletion for python
" Plug 'neoclide/coc.nvim', {'branch': 'release'} "Make your Vim/Neovim as smart as VSCode.
" Plug 'fannheyward/coc-pyright'                  "Autocompletion for python
" Plug 'lifepillar/vim-solarized8'                "Nice colorscheme
" Plug 'JuliaEditorSupport/julia-vim'           "Support for the Julia programming language
" Plug 'cjrh/vim-conda'                         "Consider this one!

" All of your Plugins must be added before the following line
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Python paths if using vim
" To get Python3 working in GVim, install GVim then install a python version that matches the 
" build (e.g. 64 bit) and the version used to compile vim. It is also necessary to add 
" to the Path the env folder, and set the PythonPath to the python library
" let $Path = "C:\\Users\\GARC7680\\AppData\\Local\\Continuum\\anaconda3\\envs\\py38;".$Path
" let $PYTHONPATH = "C:\\Users\\GARC7680\\AppData\\Local\\Continuum\\anaconda3\\envs\\py38\\Lib"

" Configure fzf
" Set up commands like ctrl-p
nmap <C-P> :Files<CR>
nmap <C-B> :Buffers<CR>
nmap <C-L> :Lines<CR>
nmap <C-T> :Tags<CR>

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R .'

" Configure preview window
let $PATH = "C:\\Users\\GARC7680\\AppData\\Local\\Programs\\Git\\usr\\bin;".$PATH
let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-s']
" Set up tagbar
nmap <F8> :TagbarToggle<CR>
let g:tagbar_ctags_bin = 'C:\Data\Software\ctags58\ctags.exe'

" Set up Syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['html', 'javascript'],
                            \ 'passive_filetypes': ['python'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1 "Tell syntastic to aggregate errors from all checkers
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_python_checkers = ['flake8', 'pylint']  "Set specific linters only

"Increase length checking for python
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_post_args="--max-line-length=120"

"Ignore messages for current project
let g:syntastic_python_pylint_quiet_messages = { 'regex': ['bad-continuation',
                                                         \ 'invalid-name'] } 

" A mapping to toggle syntastic
silent! nmap <F6> :SyntasticToggleMode<CR>

" Set up Jedi
let g:jedi#popup_select_first = 1 "Tell jedi to autocomplete with first item
let g:jedi#use_tabs_not_buffers = 1 "Make jedi-vim use tabs when going to a definition
let g:jedi#smart_auto_mappings = 1 "jedi will automatically add the import statement
set completeopt=menuone,longest,preview
autocmd FileType python setlocal completeopt-=preview  " No need to display the full docstring upon completion

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Neovim configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader="\<Space>"

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" Highlight cursor line and set color.
set cursorline

" Ruler (line, column and % at the right bottom).
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 

" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set tm=500

" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

" Set background (dark/light)
set background=dark

" Set colorscheme depending on terminal or gui (font, size, etc.)
if has("nvim") || has("gui_running")
    set guifont=Consolas:h12
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    set guioptions-=e "use text-only tabline
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set guitablabel=%M\ %t
    colorscheme nord
else
    " set nocompatible
    " set term=xterm
    " set t_Co=256
    " let &t_AB="\e[48;5;%dm"
    " let &t_AF="\e[38;5;%dm"
    " set termencoding=utf8
    " inoremap <Char-0x07F> <BS>
    " nnoremap <Char-0x07F> <BS>
    colorscheme nord
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set python syntax for .pyt files
" https://stackoverflow.com/questions/11666170/persistent-set-syntax-for-a-given-filetype/12143982#12143982
augroup pythontoolbox
	au!
	autocmd BufNewFile,BufRead *.pyt set syntax=python
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Linebreak on 500 characters
set lbr
set tw=500 " Set tw to 80 and reformat with <movement/visual selection>gq

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Set up different indentation settings for specific files
au BufNewFile,BufRead *.js, *.html, *.css, *.tex
      \ set tabstop=2
      \ set softtabstop=2
      \ set shiftwidth=2

" Set syntax coloring for XAML
au BufNewFile,BufRead *.xaml setf xml

" Set syntax textwidth for python files 
au BufNewFile,BufRead *.py set tw=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
" set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"Add syntastic elements
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Fast saving
nmap <leader>w :w!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" alias the "anonymous" register as the * register 
set clipboard=unnamed

" Toggle paste mode on and off
set pastetoggle=<F2>

" Get count of word under cursor
map <leader>* *<C-O>:%s///gn<CR>

" Toggle numbers
map <F12> :set number!<CR>

" trigger `autoread` when files changes on disk
  set autoread
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
  autocmd FileChangedShellPost *
    \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VisualSelection, necessary for searching highlighted text
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Necessary for VisualSelection function
function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction 

" Create specific marks for DAT files
augroup datafiles
    au!
    autocmd BufNewFile,BufRead *.dat let @q = "/General Data\<CR>m1/\\[2\\] Determinand\<CR>m2/\\[3\\] Reaches\<CR>m3/\\[4\\] River Flow\<CR>m4/\\[5\\] River Quality\<CR>m5/\\[F\\] Effluent Flow & Quality\<CR>mf/\\[6\\] River Quality Targets\<CR>m6/\\[7\\] Features\<CR>m7gg"
    autocmd BufNewFile,BufRead *.dat normal! @q
augroup END

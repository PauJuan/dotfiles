"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: 
"       Pau Juan Garcia 
"
" Version:
" 		1.1 - 08/02/2019
"
" Sections:
"    -> Vim-Plug (manage plugins)
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vundle (manage plugins)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Insert desired plugins
Plug 'tpope/vim-commentary'   "Commenting code easily
Plug 'tpope/vim-sensible'     "Sensible .vimrc settings
Plug 'tpope/vim-surround'     "Edit tags and surroundings easily
Plug 'tpope/vim-repeat'       "Enhancing the dot key for plugins
Plug 'tpope/vim-fugitive'     "Awesome Git Wrapper
Plug 'tpope/vim-dispatch'     "Run servers with Vim
Plug 'tpope/vim-unimpaired'   "Complementary pairs of mappings
Plug 'scrooloose/nerdtree'    "Explore filetrees nicely
Plug 'itchyny/lightline.vim'  "Practical and light status line
Plug 'ervandew/supertab'      "Autocompletion using tab
Plug 'kien/ctrlp.vim'         "Awesome fuzzy file finder
Plug 'scrooloose/syntastic'   "Syntax checking
Plug 'davidhalter/jedi-vim'   "Autocompletion for python
Plug 'altercation/vim-colors-solarized' "Nice colorscheme for the console version

" All of your Plugins must be added before the following line
" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Add folders to path
" set path+='C:\Users\GARC7680\.vim'

" Select python-mode
let g:pymode_python = 'python3'

" Make CtrlP open files in a new tab
let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<2-LeftMouse>'],
    \ 'AcceptSelection("t")': ['<cr>'],
    \ }

" Set up Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let b:syntastic_mode="passive"
let g:syntastic_mode_map = { 'mode': 'passive',
                            \ 'active_filetypes': ['html', 'javascript'],
                            \ 'passive_filetypes': ['python'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_cs_checkers = ['code_checker']
let g:syntastic_aggregate_errors = 1 "Tell syntastic to aggregate errors from all checkers
" let g:syntastic_debug=1 "In case it needs to be debugged

" Set up Jedi
let g:jedi#popup_select_first = 1 "Tell jedi to autocomplete with first item
let g:jedi#use_tabs_not_buffers = 1 "Make jedi-vim use tabs when going to a definition
let g:jedi#smart_auto_mappings = 1 "jedi will automatically add the import statement
set completeopt=menuone,longest,preview

"Ignore messages for current project
let g:syntastic_python_pylint_quiet_messages = { 'regex': ['bad-continuation',
                                                         \ 'invalid-name'] } 

"Disable length checking for python
let g:syntastic_python_pylint_post_args="--max-line-length=120"
let g:syntastic_python_flake8_post_args="--max-line-length=120"

" A mapping to toggle syntastic
silent! nmap <F6> :SyntasticToggleMode<CR>

" Set up Omnisharp
" let g:OmniSharp_server_path = 'C:\Users\GARC7680\.omnisharp\omnisharp.http-win-x64\OmniSharp.exe'
" let g:OmniSharp_translate_cygwin_wsl = 1
" let g:OmniSharp_proc_debug = 1
" let g:OmniSharp_loglevel = 'debug'

"Toggle colorscheme with F5 (only with solarized plugin)
call togglebg#map("<F5>")
" NOTE to toggle the lightline theme as well (https://github.com/itchyny/lightline.vim/issues/178)
" https://blog.sleeplessbeastie.eu/2018/05/21/how-to-integrate-lightline-status-line-plugin-for-vim-with-solarized-theme/
" https://github.com/itchyny/lightline.vim/issues/104

" Set python dll manually
"let &pythonthreedll='C:\\Users\\Pau\\Miniconda3\\python36.dll'
" set pythonthreedll='C:\Users\GARC7680\AppData\Local\Continuum\anaconda3\python37.dll'

" Sets how many lines of history VIM has to remember
set history=500

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file 
" (useful for handling the permission-denied error)
" command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim

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
" :highlight CursorLine ctermbg=NONE

" Ruler (line, column and % at the right bottom).
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
" set backspace=eol,start,indent
" set whichwrap+=<,>,h,l

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
if has("gui_running")
    set guifont=Consolas:h12
    set guioptions-=m "remove menu bar
    set guioptions-=T "remove toolbar
    " set guioptions-=r  "remove right-hand scroll bar
    " set guioptions-=L  "remove left-hand scroll bar
    set guioptions-=e "use text-only tabline
    set t_Co=256
    set guitablabel=%M\ %t
    colorscheme solarized
else
    set term=xterm
    set t_Co=256
    let &t_AB="\e[48;5;%dm"
    let &t_AF="\e[38;5;%dm"
    set termencoding=utf8
    set nocompatible
    inoremap <Char-0x07F> <BS>
    nnoremap <Char-0x07F> <BS>
    let g:solarized_termtrans = 1
    colorscheme desert
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

" Set syntax coloring for XAML
au BufNewFile,BufRead *.xaml setf xml

" Set syntax textwidth for python files 
au BufNewFile,BufRead *.py set tw=80

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
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

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
" vnoremap <silent> * :call VisualSelection('f', '')<CR>
" vnoremap <silent> # :call VisualSelection('b', '')<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
" map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
" map <leader>ba :bufdo bd<cr>

" Move through buffers (better use shortcuts from vim-unimpaired)
" map <leader>l :bnext<cr>
" map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
" map <leader>tn :tabnew<cr>
" map <leader>to :tabonly<cr>
" map <leader>tc :tabclose<cr>
" map <leader>tm :tabmove 
" map <leader>t<leader> :tabnext 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/<CR>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>
"
" Map CtrlP buffer mode to Ctrl + B.
nnoremap <C-b> :CtrlPBuffer<cr> 

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
      \ 'colorscheme': 'solarized',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
" map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac (also vim-unimpaired)
" nmap <M-j> mz:m+<cr>`z
" nmap <M-k> mz:m-2<cr>`z
" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

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
" Remove the Windows ^M - when the encodings gets messed up
"noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
"map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" alias the "anonymous" register as the * register 
set clipboard=unnamed

" Toggle paste mode on and off
set pastetoggle=<F2>

" Get count of word under cursor
map <leader>* *<C-O>:%s///gn<CR>

" Toggle numbers
map <F12> :set number!<CR>

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

" Returns true if paste mode is enabled (not necessary the way I format 
" the status line now
"
" function! HasPaste()
"     if &paste
"         return 'PASTE MODE  '
"     endif
"     return ''
" endfunction

" Don't close window, when deleting a buffer
" command! Bclose call <SID>BufcloseCloseIt()
" function! <SID>BufcloseCloseIt()
"     let l:currentBufNum = bufnr("%")
"     let l:alternateBufNum = bufnr("#")

"     if buflisted(l:alternateBufNum)
"         buffer #
"     else
"         bnext
"     endif

"     if bufnr("%") == l:currentBufNum
"         new
"     endif

"     if buflisted(l:currentBufNum)
"         execute("bdelete! ".l:currentBufNum)
"     endif
" endfunction



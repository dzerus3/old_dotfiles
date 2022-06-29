" Note to self: addons are stored in one or more directories in
" ~/.local/share/nvim/site/pack

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim edits
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')
    " Resets default vim cursor shape
    "set guicursor=

    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" The number of lines that will remain visible above/below
" cursor when scrolling
set so=7

" Set a color scheme
set background=dark
colorscheme torte

" Visible trailing whitespace
set list
set listchars=trail:░,tab:▸\ 
"set listchars=tab:>\ ,trail:░,extends:>,precedes:<,nbsp:+

" Height of the command bar
set cmdheight=1

" Case sensitive search only when at least one capital is
" present
set smartcase

" Highlight search results
set hlsearch

" Start searching before pressing enter
set incsearch

" Make it so vim handles numbers with leading zeroes correctly
set nrformats-=octal

" Disables audio effect on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Enables line numbers
set number
set relativenumber

"...but not in text files
au BufReadPost,BufNewFile *.md,*.txt,*.tex set nonumber
au BufReadPost,BufNewFile *.md,*.txt,*.tex set norelativenumber

" Remember position after exiting file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Enable yanking between windows
set clipboard=unnamed

" Sets the number of lines of history that will be stored
set history=50

" Enable filetype plugins
"filetype plugin on
"filetype indent on

" A buffer becomes hidden when it is abandoned
"set hid

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Allows backspace to delete everything
set backspace=eol,start,indent

" Don't redraw while executing macros
set lazyredraw

" Ignore useless files in wildcards
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" Auto read when file is changed outside vim
"set autoread
"au FocusGained,BufEnter * checktime

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Set tab size to 4 spaces
set tabstop=4 shiftwidth=0

" Auto convers tabs to spaces
"set et

"set ai "Auto indent"
"set si "Smart indent"
"set wrap "Wrap lines"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colemak remappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Movement keys at neio
noremap n h
noremap e j
noremap i k
noremap o l
noremap ge gj
noremap gi gk

" Insert mode now bound to l
noremap l i
noremap l I
noremap gl gi

" Search result navigation with h
noremap h n
noremap H N

" Insert mode with newline is now on k
noremap k o
noremap K O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" E and I function like PageUp/Down
nnoremap E <C-f>
nnoremap I <C-b>

" Ctrl-D to delete without copying
map <silent> <C-D> "_dd
vnoremap <silent> <C-D> "_d

" Enter clears search highlighting
nnoremap <silent><CR> :noh<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Easy window switching (leader key)
nmap <silent> <leader>i :wincmd k<CR>
nmap <silent> <leader>e :wincmd j<CR>
nmap <silent> <leader>n :wincmd h<CR>
nmap <silent> <leader>o :wincmd l<CR>

" Easy window switching (alt key)
" Much more convenient, but uses up tmux keyspace
"nmap <silent> <A-i> :wincmd k<CR>
"nmap <silent> <A-e> :wincmd j<CR>
"nmap <silent> <A-n> :wincmd h<CR>
"nmap <silent> <A-o> :wincmd l<CR>

" Arrow keys for tab management
" Disabled in favor of tmux
"nmap <silent> <Left> <Esc>:tabprev<CR>
"nmap <silent> <Right> <Esc>:tabnext<CR>
"nmap <silent> <Up> <Esc>:tabnew<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tweaks
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Creating newline without insert mode
noremap <A-k> o<Esc>
noremap <A-K> O<Esc>

" x and X don't copy when deleting
noremap <silent> x "_x
noremap <silent> X "_X

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom additions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes writing a bracket and then pressing enter autoclose
" and create new line in between.
inoremap {<CR> {<CR>}<C-o>O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Persistent undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" try
"     set undodir=~/.vim_runtime/temp_dirs/undodir
"     set undofile
" catch
" endtry
try
    set undodir=~/.cache/nvim/undo
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2

function! WindowNumber()
	let str=tabpagewinnr(tabpagenr())
	return str
endfunction

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ Win:%{WindowNumber()}\ \ \ Line:\ %l\ \ Column:\ %c

" Returns true if paste mode is enabled
function! HasPaste()
	if &paste
		return 'PASTE MODE  '
	endif
	return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start Tagbar
cnoreabbrev TT TagbarToggle

" Allows switching windows without tagbar changing content
cnoreabbrev Z TagbarTogglePause

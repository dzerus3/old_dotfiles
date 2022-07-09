" Note to self: addons are stored in one or more directories in
" ~/.local/share/nvim/site/pack

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim edits
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"if has('nvim')
    " Resets default vim cursor shape
    "set guicursor=
"endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
let mapleader = " "
let maplocalleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Moves disposable files into corresponding XDG directories Also
" enables persistent undo.
if has('nvim')
	set undodir=$XDG_STATE_HOME/nvim/undo
	set undofile

	" I personally think these belong in STATE_HOME, but I'll keep
	" 'em here since the defaults are good enough.
	"set directory=$XDG_STATE_HOME/nvim/swap
	"set shada+=n$XDG_STATE_HOME/nvim/shada
else
	set undodir=$XDG_STATE_HOME/vim/undo
	set undofile

	set directory=$XDG_DATA_HOME/vim/swap
	set backupdir=$XDG_DATA_HOME/vim/backup
	set viminfo+=n$XDG_DATA_HOME/vim/viminfo
	set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
    let &packpath = &runtimepath
endif

" The number of lines that will remain visible above/below
" cursor when scrolling
set so=7

" Set a color scheme
" I use https://github.com/w0ng/vim-hybrid with a few tweaks
" ported from https://github.com/AlessandroYorba/Alduin
set background=dark
colorscheme hybrid

" Visible trailing whitespace
set list
set listchars=trail:░,tab:▸\ ,extends:>,precedes:<,nbsp:+

" Height of the command bar
set cmdheight=1

" Case sensitive search only when at least one capital is
" present
set ignorecase
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

" Enables relative numbers
set relativenumber

"...but not in text files
autocmd FileType markdown,text,plaintex set norelativenumber

" Remember position after exiting file
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Enable yanking between windows
set clipboard=unnamed

" Sets the number of lines of history that will be stored
set history=50

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2

" Allows backspace to delete everything
set backspace=eol,start,indent

" Don't redraw while executing macros
set lazyredraw

" Ignore useless files with :e
" Version control
set wildignore=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
" Compiled files
set wildignore+=*.o,*.elf,*.pyc,*.bin,*.exe,*.msi
" Images
set wildignore+=*.png,*.jpg,*.jpeg,*.gif,*.webp,*.ico
" Binary documents
set wildignore+=*.pdf,*.doc*,*.xls*,*.ppt*,*.odt,*.djvu,*.fb2
" Archives
set wildignore+=*.zip,*.tar,*.rar,*.7z,*.gz,*.bz2
" Audio
set wildignore+=*.mp3,*.opus,*.wav,*.flac,*.m4a,*.m4b
" Video
set wildignore+=*.mp4,*.mkv,*.webm,*.avi
" Miscellaneous
set wildignore+=*.dat,*.db,*.iso,*.img,*.torrent



" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Set tab size to 4 spaces
set tabstop=4 shiftwidth=0

" Enable filetype plugins
"filetype plugin on
"filetype indent on

" A buffer becomes hidden when it is abandoned
"set hid

" Auto read when file is changed outside vim
"set autoread
"au FocusGained,BufEnter * checktime

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
noremap L I
noremap gl gi

" Search result navigation with h
noremap h n
noremap H N

" Insert mode with newline is now on k
noremap k o
noremap K O

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" W and B move to beginning/end of word inclusive
noremap W e
noremap B gE

" Sets N and O for easier horizontal navigation
noremap N ,
noremap O ;

" E and I function like PageUp/Down
nnoremap E <C-f>
nnoremap I <C-b>

" Lower case j joins lines.
nnoremap j J

" Ctrl-D to delete without copying
noremap <silent> <C-d> "_dd
vnoremap <silent> <C-d> "_d

" <leader>l toggles line numbers
noremap <silent> <leader>l :set relativenumber!<CR>
"noremap <silent> <leader>l :set relativenumber! <bar> set nu!<CR>

" Enter clears search highlighting
nnoremap <silent><CR> :noh<CR>

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>

" Easy window switching (leader key)
nnoremap <silent> <leader>n :wincmd h<CR>
nnoremap <silent> <leader>e :wincmd j<CR>
nnoremap <silent> <leader>i :wincmd k<CR>
nnoremap <silent> <leader>o :wincmd l<CR>

" Disables arrow keys
nmap <silent> <Left> <Nop>
nmap <silent> <Right> <Nop>
nmap <silent> <Up> <Nop>
nmap <silent> <Down> <Nop>

" Easy window switching (alt key)
" Much more convenient, but uses up tmux keyspace
"nnoremap <silent> <A-i> :wincmd k<CR>
"nnoremap <silent> <A-e> :wincmd j<CR>
"nnoremap <silent> <A-n> :wincmd h<CR>
"nnoremap <silent> <A-o> :wincmd l<CR>

" Arrow keys for tab management
" Disabled in favor of tmux
"nnoremap <silent> <Left> <Esc>:tabprev<CR>
"nnoremap <silent> <Right> <Esc>:tabnext<CR>
"nnoremap <silent> <Up> <Esc>:tabnew<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Abbreviations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

iabbrev EUR €
iabbrev GBP £
iabbrev RUB ₽
iabbrev ccc ©
iabbrev tmk ®
iabbrev --- —
iabbrev lenny ( ͡° ͜ʖ ͡°)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Custom additions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Makes writing a bracket and then pressing enter autoclose
" and create new line in between.
inoremap {<CR> {<CR>}<C-o>O

" Creating newline without insert mode
noremap <A-k> o<Esc>
noremap <A-K> O<Esc>

" x and X don't copy when deleting
noremap <silent> x "_x
noremap <silent> X "_X

" Keymaps for working with vimrc
" Mnemonics: rc edit, rc reload
nnoremap <leader>re :vsplit $MYVIMRC<cr>
nnoremap <leader>rr :source $MYVIMRC<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set font according to system. Ripped from amix's vimrc.
if has("gui_gtk2")
    set gfn=Hack\ 14,IBM\ Plex\ Mono\ 14
elseif has("linux")
    set gfn=Hack\ 14,IBM\ Plex\ Mono\ 14
elseif has("unix")
    set gfn=Monospace\ 11
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
" Inspired by elements of:
" https://stackoverflow.com/a/5380230
" https://stackoverflow.com/a/10416234
" https://github.com/amix/vimrc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the status line
set laststatus=2
set termguicolors

" Colors for status line
highlight User1 guifg=#CE933B guibg=#333333
highlight User2 guifg=#76CE3B guibg=#333333
highlight User3 guifg=#933BCE guibg=#333333
highlight User4 guifg=#EA5031 guibg=#333333
highlight User5 guifg=#F2E863 guibg=#333333
highlight User6 guifg=#CCCCCC guibg=#333333
highlight User7 guifg=#FFFFFF guibg=#333333

set statusline=
" Buffer number
set statusline +=%1*\ %02n\ %*
" File name (up to 40 characters)
set statusline +=%2*%<%.40t%*
" File type
set statusline +=%3*\ %Y\ %*
" Flags (modified, readonly, help, etc.)
set statusline +=%4*%m%r%w%h%*
" Separator
set statusline +=%1*%=
" Column number
set statusline +=%5*%c%6*:
" Row number/Number of rows
set statusline +=%5*%l%6*/%1*%L
" Percentage of location
set statusline +=%7*%6p%%\ \ 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Start Tagbar
cnoreabbrev TT TagbarToggle

" Allows switching windows without tagbar changing content
cnoreabbrev Z TagbarTogglePause

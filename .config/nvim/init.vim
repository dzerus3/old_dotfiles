"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" nvim edits
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    " Resets normal cursor shape
    " set guicursor=

    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Leader key
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
let mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rebinding movement for Colemak
nnoremap n h|xnoremap n h|onoremap n h|vnoremap n h
nnoremap e j|xnoremap e j|onoremap e j|vnoremap e j
nnoremap i k|xnoremap i k|onoremap i k|vnoremap i k
nnoremap o l|xnoremap o l|onoremap o l|vnoremap o l

" Insert mode now bound to t
nnoremap t i
nnoremap T I

" TODO: Doesn't seem to work
" E and I function like PageUp/Down
nnoremap E <C-f>
nnoremap I <C-b>

" gt now acts like gi
nnoremap gt gi

" ge and gi move between wrapped long line
nnoremap ge gj
nnoremap gi gk

" t is now at j
nnoremap j t|xnoremap j t|onoremap j t|
nnoremap J T|xnoremap J T|onoremap J T|

" Joining lines (shift + J) is now done with gj
nnoremap gj J|xnoremap gj J|onoremap gj J|

" Next result is now bound to l
nnoremap h n|xnoremap h n|onoremap h n|
nnoremap H N|xnoremap H N|onoremap H N|

" Insert mode with newline is now on k
nnoremap k o|xnoremap k o|onoremap k o|
nnoremap K O|xnoremap K O|onoremap K O|

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Minor Additions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Creating newline without insert mode
nnoremap <A-k> o<Esc>|xnoremap <A-k> o<Esc>|onoremap <A-k> o<Esc>|
nnoremap <A-K> O<Esc>|xnoremap <A-K> O<Esc>|onoremap <A-K> O<Esc>|

" x and X don't copy when deleting
nnoremap <silent> x "_x
vnoremap <silent> x "_x
nnoremap <silent> X "_X

" Ctrl-D to delete line without copying it
map <silent> <C-D> "_dd
vnoremap <silent> <C-D> "_d

" This removes last search highlighting by hitting return
nnoremap <silent><CR> :noh<CR>

" f and F remapped to N and O
nnoremap N F
nnoremap O f

" t and T remapped to Ctrl + N and Ctrl + O
nnoremap <C-n> T
nnoremap <C-o> t

" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> z :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" Abbreviate `:Make` to `:m`
cnoreabbrev m Make

" :W saves with sudo
"command W :w !sudo tee "%" > /dev/null

" Easy window switching (leader key)
" Should always work; uncomment if solution below fails
"nmap <silent> <leader>i :wincmd k<CR>
"nmap <silent> <leader>e :wincmd j<CR>
"nmap <silent> <leader>n :wincmd h<CR>
"nmap <silent> <leader>o :wincmd l<CR>

" Easy window switching (alt key)
" May break with some setups
nmap <silent> <M-i> :wincmd k<CR>
nmap <silent> <M-e> :wincmd j<CR>
nmap <silent> <M-n> :wincmd h<CR>
nmap <silent> <M-o> :wincmd l<CR>

" Better tab management
nmap <silent> <A-n> <Esc>:tabprev<CR>
nmap <silent> <A-o> <Esc>:tabnext<CR>
nmap <silent> <C-Up> <Esc>:tabnew<CR>
" map <C-Down> <Esc>:q<CR>

" leader + t Inserts a character
nnoremap <leader>t i_<Esc>r
nnoremap <leader>a a_<Esc>r

" Makes writing a bracket and then pressing enter autoclose
" and create new line in between.
inoremap {<CR> {<CR>}<C-o>O

" TODO what is this?
" nnoremap <Space> :exec "normal i".nr2char(getchar())."\e"<CR>
" nnoremap <Space> :exec "normal a".nr2char(getchar())."\e"<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make it so vim doesn't chimp out when incrementing numbers with preceding
" zeroes
set nrformats-=octal

" Displays trailing whitespace
set list
set listchars=tab:>\ ,trail:░,extends:>,precedes:<,nbsp:+

" Enable syntax highlighting by default
syntax enable

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Set 7 lines to the cursor - when moving vertically using j/k
" TODO rewrite description
set so=7

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Don't redraw while executing macros
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" Set line numbers
set number
set relativenumber

"...but not in text files
au BufReadPost,BufNewFile *.md,*.txt,*.tex set nonumber
au BufReadPost,BufNewFile *.md,*.txt,*.tex set norelativenumber

" Enable yanking between windows
set clipboard=unnamed
"
" Sets how many lines of history VIM has to remember
set history=50

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" Remembers last position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

" Colorscheme
set background=dark
colorscheme torte

" Font for Windows
set gfn=IBM\ Plex\ Mono\ 14,:Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent

" Ignore case when searching
set ignorecase

" Start searching before pressing enter
set incsearch

" How many tenths of a second to blink when matching brackets
set mat=2

" Be smart when using tabs ;)
" set smarttab

" Set tab size to 4 spaces
set tabstop=4 shiftwidth=0

" Auto convers tabs to spaces
" set et

set ai "Auto indent"
set si "Smart indent"
set wrap "Wrap lines"

let g:indent_guides_start_level=2
let g:indent_guides_size = 1

let g:indent_guides_enable_on_vim_startup = 1

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

" What is this? TODO
let i = 1
while i <= 9
    execute 'nnoremap <leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile
"
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ale config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
\   'javascript': ['jshint'],
\   'python': ['flake8'],
\   'go': ['go', 'golint', 'errcheck']
\}

nmap <silent> <leader>l <Plug>(ale_next_wrap)

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0

let g:ale_cpp_clang_options = '-std=c++17 -Wall'
let g:ale_cpp_gcc_options = '-std=c++17 -Wall'

let g:clang_library_path='/usr/lib/llvm-9/lib/'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Delete trailing white space on save
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
" => CTRL-P
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

" let g:ctrlp_map = '<C-f>'
map <leader>j :CtrlP<cr>
map <C-b> :CtrlPBuffer<cr>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Turn persistent undo on 
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undodir=~/.vim_runtime/temp_dirs/undodir
    set undofile
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start Tagbar
cnoreabbrev TT TagbarToggle

" Allows switching windows without tagbar changing content
cnoreabbrev Z TagbarTogglePause

""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

" TODO
" au FileType python map <buffer> F :set foldmethod=indent<cr>

au FileType python inoremap <buffer> $r return 
au FileType python inoremap <buffer> $i import 
au FileType python inoremap <buffer> $p print 
au FileType python inoremap <buffer> $f # --- <esc>a
au FileType python map <buffer> <leader>1 /class 
au FileType python map <buffer> <leader>2 /def 
au FileType python map <buffer> <leader>C ?class 
au FileType python map <buffer> <leader>D ?def 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Hexadecimal mode
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <C-Down> :Hexmode<CR>
inoremap <C-Down> <Esc>:Hexmode<CR>
vnoremap <C-Down> :<C-U>Hexmode<CR>

command -bar Hexmode call ToggleHex()

" helper function to toggle hex mode
function ToggleHex()
  " hex mode should be considered a read-only operation
  " save values for modified and read-only for restoration later,
  " and clear the read-only flag for now
  let l:modified=&mod
  let l:oldreadonly=&readonly
  let &readonly=0
  let l:oldmodifiable=&modifiable
  let &modifiable=1
  if !exists("b:editHex") || !b:editHex
    " save old options
    let b:oldft=&ft
    let b:oldbin=&bin
    " Saves to prevent no changes warning
    w
    " set new options
    setlocal binary " make sure it overrides any textwidth, etc.
    silent :e " this will reload the file without trickeries
              "(DOS line endings will be shown entirely )
    let &ft="xxd"
    " set status
    let b:editHex=1
    " switch to hex editor
    %!xxd
  else
    " restore old options
    let &ft=b:oldft
    if !b:oldbin
      setlocal nobinary
    endif
    " set status
    let b:editHex=0
    " return to normal editing
    %!xxd -r
  endif
  " restore values for modified and read only state
  let &mod=l:modified
  let &readonly=l:oldreadonly
  let &modifiable=l:oldmodifiable
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

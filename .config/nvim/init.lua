---------------------------------------------------------------
-- Helper functions
---------------------------------------------------------------

-- https://github.com/nanotee/nvim-lua-guide
function map(mode, shortcut, command)
    vim.api.nvim_set_keymap(
        mode,
        shortcut,
        command,
        {
            noremap = true,
            silent = true
        }
    )
end

---------------------------------------------------------------
-- Leader key
---------------------------------------------------------------

-- With a map leader it's possible to do extra key combinations
vim.g.mapleader = " "

----------------------------------------------------------------
-- Vim settings
----------------------------------------------------------------

-- Workaround for vim to reset cursor when leaving
vim.cmd([[
    augroup resetcursor
        autocmd!
        autocmd VimLeave * set guicursor=a:ver1-blinkon0
    augroup end
]])

-- Enable syntax highlighting
vim.g.syntax = true

-- Enables 24-bit colors
vim.opt.termguicolors = true

-- Sets encoding to UTF-8
vim.opt.encoding = "UTF-8"

-- Folding
vim.opt.foldmethod = "indent"

-- Disables folding by default
vim.opt.foldenable = false

-- Enables persistent undo
-- FIXME: The if statement doesn't seem to work correctly
vim.opt.undofile = true
if(vim.env.XDG_STATE_HOME == nil)
    then
    vim.opt.undodir = vim.env.HOME .. "/.local/state/nvim/undo"
else
    vim.opt.undodir = vim.env.XDG_STATE_HOME .. "/nvim/undo"
end

-- Disables swapfiles
vim.opt.swapfile = false

-- Number of lines that remain visible cursor when scrolling
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 7

-- Disables showing mode on the bottom. Should be obvious from cursor
--vim.opt.showmode = false

-- Disables wrapping
vim.opt.wrap = false

-- Visible whitespace
-- See :help lua line 1139
vim.opt.list = true
vim.opt.listchars = {
    trail      = "-",
    tab        = "▸ ",
    extends    = "❱",
    precedes   = "❰",
    multispace = "·",
    lead       = " "
}

-- Don't insert completion option until it is selected
vim.opt.completeopt = {
    "noinsert",
    "menuone",
    "noselect"
}

-- Height of the command bar
vim.opt.cmdheight = 1

-- Case sensitive search only when at least one capital is
-- present
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Highlight search results
vim.opt.hlsearch = true

-- Start searching before pressing enter
vim.opt.incsearch = true

-- Make it so vim handles numbers with leading zeroes correctly
vim.opt.nrformats:remove {"octal"}

-- Enables relative numbers
vim.opt.relativenumber = true
-- Enables highlighting of current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Tweaks for working with manpages, help, and plaintext
vim.cmd([[
    augroup plaintext
        autocmd!

        " Applies to markdown, plaintext, and LATEX
        autocmd FileType markdown,text,plaintex
        \ setlocal norelativenumber  " Disables relative numbers
        autocmd FileType markdown,text,plaintex
        \ setlocal wrap              " Enables line wrapping
        autocmd FileType markdown,text,plaintex
        \ setlocal linebreak         " Makes lines break at spaces
        autocmd FileType markdown,text,plaintex
        \ setlocal display+=lastline " TODO: What does this do?

        " Applies to man and help pages
        autocmd FileType man,help
        \ setlocal scrolloff=99999    " Always centers screen
        autocmd FileType man,help
        \ nnoremap <buffer> q :q!<CR> " Rebinds q to quit
    augroup end
]])

-- Remember position after exiting file
vim.cmd([[
    augroup fileposition
        autocmd!
        autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft =~ 'gitcommit'
        \ | exe "normal! g'\"" | endif
    augroup end
]])

-- Sets the number of lines of history that will be stored
vim.opt.history = 50

-- Show matching brackets when text indicator is over them
vim.opt.showmatch = true

-- How many tenths of a second to blink when matching brackets
vim.opt.matchtime = 2

-- Allows backspace to delete everything
vim.opt.backspace = {
    "eol",
    "start",
    "indent"
}

vim.opt.wrap = false

-- Don't redraw while executing macros; improves performance
vim.opt.lazyredraw = true

-- Ignore useless files with :e
-- Check :help lua.txt line 1114
vim.opt.wildignore = {
    -- Version control
    "*/.git/*", "*/.hg/*", "*/.svn/*", "*/.DS_Store",
    -- Compiled files
    "*.o", "*.elf", "*.pyc", "*.bin", "*.exe", "*.msi",
    -- Images
    "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.ico",
    -- Binary documents
    "*.pdf", "*.doc*", "*.xls*", "*.ppt*", "*.odt", "*.djvu", "*.fb2",
    -- Archives
    "*.zip", "*.tar", "*.rar", "*.7z", "*.gz", "*.bz2",
    -- Audio
    "*.mp3", "*.opus", "*.wav", "*.flac", "*.m4a", "*.m4b",
    -- Video
    "*.mp4", "*.mkv", "*.webm", "*.avi",
    -- Miscellaneous
    "*.dat", "*.db", "*.iso", "*.img", "*.torrent"
}

-- Set tab size to 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

-- Auto convert tabs to spaces
vim.opt.expandtab = true

-- Disables netrw
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

---------------------------------------------------------------
-- Colemak remappings
---------------------------------------------------------------

-- Movement keys rebound to neio
map("", "n",  "h")
map("", "e",  "j")
map("", "i",  "k")
map("", "o",  "l")
map("", "ge", "gj")
map("", "gi", "gk")

-- Insert mode now bound to l
map("", "l", "i")
map("", "L", "I")
map("", "gl", "gi")

-- Search result navigation with h
map("", "h",  "n")
map("", "H",  "N")
-- Search forward/backward and select
map("", "gh", "gn")
map("", "gH", "gN")
map("", "gn", "")
map("", "gN", "")
map("", "go", "")
map("", "gO", "")

-- Insert mode with newline is now on k
map("", "k", "o")
map("", "K", "O")

---------------------------------------------------------------
-- Custom mappings
---------------------------------------------------------------

-- ze and zi move cursor to top/bottom of visible screen
map("", "ze", "L")
map("", "zi", "H")

-- W and B move to beginning/end of word inclusive
map("", "W", "e")
map("", "B", "gE")

-- E and I function like PageUp/Down
map("", "E", "<C-f>")
map("", "I", "<C-b>")

-- Lower case j joins lines
map("", "j", "J")

-- Leader-action to delete without copying
map("",  "<leader>x", "\"_x")
map("",  "<leader>X", "\"_X")
map("v",  "<leader>x", "\"_x")

map("",  "<leader>s", "\"_s")
map("",  "<leader>S", "\"_S")
map("v", "<leader>s", "\"_s")

map("",  "<leader>c", "\"_c")
map("",  "<leader>C", "\"_C")
map("v", "<leader>c", "\"_c")

map("",  "<leader>d", "\"_d")
map("",  "<leader>D", "\"_D")
map("v", "<leader>d", "\"_d")

-- Hack to work around conflict with `d`elete `i`n
map("n",  "di", "dk")
map("n",  "dd", "dd")

-- Enter clears toggles highlighting
map("", "<CR>", ":set hlsearch!<CR>")

-- Easy window switching
map("", "<leader>n", ":wincmd h<CR>")
map("", "<leader>e", ":wincmd j<CR>")
map("", "<leader>i", ":wincmd k<CR>")
map("", "<leader>o", ":wincmd l<CR>")

-- Creating newline without insert mode
map("", "<C-k>",   "o<Esc>o")
map("", "<C-S-K>", "O<Esc>O")

-- Movement between previous motions
map("", "<C-H>",   "<C-O>")
map("", "<C-S-H>", "<C-I>")

-- <leader>l toggles line numbers
map("n", "<leader>l", ":set number!<CR>")
-- <leader>r toggles relative numbers
map("n", "<leader>r", ":set relativenumber!<CR>")
-- <leader>a toggles between the two
map("n", "<leader>a", ":set relativenumber!<CR>:set number!<CR>")

-- Leader + h allows highlighting `l`ine or `c`olumn
map("n", "<leader>hl", ":set cursorline!<CR>")
map("n", "<leader>hc", ":set cursorcolumn!<CR>")

-- Disables the arrow keys
map("", "<Left>",  "")
map("", "<Down>",  "")
map("", "<Up>",    "")
map("", "<Right>", "")

map("i", "<Left>",  "")
map("i", "<Down>",  "")
map("i", "<Up>",    "")
map("i", "<Right>", "")

-- Disables Ctrl + w in insert mode
map("i", "<C-w>", "")

---------------------------------------------------------------
-- Abbreviations
---------------------------------------------------------------

vim.cmd([[
    iabbrev EUR €
    iabbrev GBP £
    iabbrev RUB ₽
    iabbrev copyright_ ©
    iabbrev trademark_ ®
    iabbrev lenny_ ( ͡° ͜ʖ ͡°)
]])

---------------------------------------------------------------
-- Status line
--
-- Inspired by elements of:
-- https://stackoverflow.com/a/5380230
-- https://stackoverflow.com/a/10416234
-- https://github.com/amix/vimrc
---------------------------------------------------------------

-- Always show the status line
vim.opt.laststatus=2

-- Colors for status line
vim.cmd([[
    highlight User1 guifg=#CE933B guibg=#333333
    highlight User2 guifg=#76CE3B guibg=#333333
    highlight User3 guifg=#933BCE guibg=#333333
    highlight User4 guifg=#EA5031 guibg=#333333
    highlight User5 guifg=#F2E863 guibg=#333333
    highlight User6 guifg=#CCCCCC guibg=#333333
    highlight User7 guifg=#FFFFFF guibg=#333333
]])

vim.opt.statusline = table.concat({
    -- Buffer number
    "%1* %02n %*",
    -- File name (up to 40 characters)
    "%2*%<%.40t%*",
    -- File type
    "%3* %Y %*",
    -- Flags (modified, readonly, help, etc.)
    "%4*%m%r%w%h%*",
    -- Separator
    "%1*%=",
    -- Column number
    "%5*%c%6*:",
    -- Row number/Number of rows
    "%5*%l%6*/%1*%L",
    -- Percentage of location
    "%7*%6p%%  "
})

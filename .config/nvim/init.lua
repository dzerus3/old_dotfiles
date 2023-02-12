---------------------------------------------------------------
-- Helper functions
---------------------------------------------------------------

if(vim.env.XDG_CONFIG_HOME == nil)
	then
	dofile('~/.config/nvim/functions.lua')
else
    dofile(vim.env.XDG_CONFIG_HOME .. '/nvim/functions.lua')
end

---------------------------------------------------------------
-- Leader key
---------------------------------------------------------------

-- With a map leader it's possible to do extra key combinations
vim.g.mapleader = " "

----------------------------------------------------------------
-- Vim settings
----------------------------------------------------------------

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
vim.opt.undofile = true
if(vim.env.XDG_STATE_HOME == nil)
	then
	vim.opt.undodir = "~/.local/state/nvim/undo"
else
	vim.opt.undodir = vim.env.XDG_STATE_HOME .. "/nvim/undo"
end

-- Disables swapfiles
vim.opt.swapfile = false

-- Number of lines that remain visible cursor when scrolling
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 7

-- Disables showing mode on the bottom. Should be obvious from cursor
vim.opt.showmode = false

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

-- Auto yank to clipboard
vim.opt.clipboard="unnamedplus"

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

-- c and s no longer yank
map("",  "s", "\"_s")
map("v", "s", "\"_s")
map("",  "c", "\"_c")
map("v", "c", "\"_c")

-- Leader-D to delete without copying
map("",  "<leader>d", "\"_d")
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

-- Keymaps for working with vimrc
map("", "<leader>re", ":vsplit $MYVIMRC<cr>")
map("", "<leader>rr", ":source $MYVIMRC<cr>")

-- <leader>l toggles line numbers
map("n", "<leader>l", ":set relativenumber!<CR>")

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
-- Plugin configuration
--
-- The disableplugins check is for the installation script. I
-- suppose if you really don't like my plugin configs, you can
-- use it for that too.
---------------------------------------------------------------

if (vim.g.disableplugins == nil)
then
    if(vim.env.XDG_CONFIG_HOME == nil)
    then
        dofile('~/.config/nvim/plugincfg.lua')
    else
        dofile(vim.env.XDG_CONFIG_HOME .. '/nvim/plugincfg.lua')
    end
end

---------------------------------------------------------------
-- Packer
---------------------------------------------------------------

require("packer").startup({
    {
        -- Plugin manager
        { "wbthomason/packer.nvim" },

        -- Color theme
        { "w0ng/vim-hybrid" },

        -- Comment plugin
        { "numToStr/Comment.nvim" },

        -- Enables tab completion
        { "ervandew/supertab" },

        -- Allows incrementing dates
        { "tpope/vim-speeddating",
            requires = { "tpope/vim-repeat" }
        },

        -- Options for surrounding text with special characters
        { "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup()
            end
        },

        -- Better syntax highlighting
        { "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        },

        -- Shows possible commands for selected key
        { "folke/which-key.nvim",
            config = function()
                require("which-key").setup{}
            end
        },

        -- Better behavior in .md files
        { "preservim/vim-markdown",
            requires = {"godlygeek/tabular"},
            disable = true
        },

        -- Graphically shows undo history
        { "mbbill/undotree",
            cmd = { "UndotreeToggle", "UndotreeShow" },
            disable = true
        },

        -- Allows moving through code tags
        { "preservim/tagbar",
            cmd = "TagbarToggle",
            disable = true
        },

        -- Automatically creates character pairs
        { "windwp/nvim-autopairs",
            disable = true,
            config = function()
                require("nvim-autopairs").setup{}
            end
        },
    },
})

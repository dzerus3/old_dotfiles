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
--vim.g.maplocalleader = ","

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

-- Set a color scheme
-- I use https://github.com/w0ng/vim-hybrid with a few tweaks
-- from https://github.com/AlessandroYorba/Alduin
-- FIXME: Don't make error when theme not installed
vim.opt.background = "dark"
vim.g.hybrid_custom_term_colors = 1
vim.cmd([[
	colorscheme hybrid
	highlight Search       guifg=#dfdfaf guibg=#878787 gui=NONE ctermfg=187 ctermbg=102  cterm=NONE
	highlight MatchParen   guifg=#dfdfaf guibg=#875f5f gui=NONE ctermfg=187 ctermbg=95   cterm=NONE
	highlight Function     guifg=#af6767 guibg=NONE    gui=NONE ctermfg=95  ctermbg=NONE cterm=NONE
	highlight CursorLineNR guifg=#808890 guibg=NONE    gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
]])

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

-- Disables wrapping
vim.opt.wrap = false

-- Enables relative numbers
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

vim.cmd([[
	augroup plaintext
		autocmd!
		autocmd FileType markdown,text,plaintex
		\   setlocal norelativenumber
		\ | setlocal wrap
		\ | setlocal linebreak
		\ | setlocal display+=lastline
		autocmd FileType man,help
		\   setlocal scrolloff=99999
		\ | nnoremap <buffer> q :q!<CR>

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

-- Don't redraw while executing macros
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

-- Movement keys at neio
map("", "n", "h")
map("", "e", "j")
map("", "i", "k")
map("", "o", "l")
map("", "ge", "gj")
map("", "gi", "gk")

-- Insert mode now bound to l
map("", "l", "i")
map("", "L", "I")
map("", "gl", "gi")

-- Search result navigation with h
map("", "h", "n")
map("", "H", "N")
map("", "gh", "gn")
map("", "gH", "gN")
map("", "gn", "")
map("", "gN", "")

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

-- Sets N and O for easier horizontal navigation
--map("", "N", ",")
--map("", "O", ";")

-- E and I function like PageUp/Down
map("", "E", "<C-f>")
map("", "I", "<C-b>")

-- Lower case j joins lines
map("", "j", "J")

-- c and s no longer copy
map("",  "s", "\"_s")
map("v", "s", "\"_s")
map("",  "c", "\"_c")
map("v", "c", "\"_c")

-- Leader-D to delete without copying
map("",  "<leader>d", "\"_d")
map("v", "<leader>d", "\"_d")

-- Hack to work around conflict with `d`elete `i`n
map("", "di", "dk")
map("", "dd", "dd")

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
map("", "<C-H>", "<C-O>")
map("", "<C-S-H>", "<C-I>")

-- Keymaps for working with vimrc
map("", "<leader>re", ":vsplit $MYVIMRC<cr>")
map("", "<leader>rr", ":source $MYVIMRC<cr>")

-- <leader>l toggles line numbers
map("n", "<leader>l", ":set relativenumber!<CR>")

-- Leader + h allows highlighting `l`ine or `c`olumn
map("n", "<leader>hl", ":set cursorline!<CR>")
map("n", "<leader>hc", ":set cursorcolumn!<CR>")

-- Disables the use of the arrow keys
map("", "<Left>", "")
map("", "<Down>", "")
map("", "<Up>",   "")
map("", "<Right>", "")

map("i", "<Left>", "")
map("i", "<Down>", "")
map("i", "<Up>",   "")
map("i", "<Right>", "")

-- Disables use of Ctrl + w in insert mode
map("i", "<C-w>", "")

---------------------------------------------------------------
-- Abbreviations
---------------------------------------------------------------

vim.cmd([[
	iabbrev EUR €
	iabbrev GBP £
	iabbrev RUB ₽
	iabbrev ccc ©
	iabbrev tmk ®
	iabbrev lenny ( ͡° ͜ʖ ͡°)
]])

---------------------------------------------------------------
-- Status line
-- Inspired by elements of:
-- https://stackoverflow.com/a/5380230
-- https://stackoverflow.com/a/10416234
-- https://github.com/amix/vimrc
---------------------------------------------------------------

-- Always show the status line
vim.opt.laststatus=2
vim.opt.termguicolors=true

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

vim.opt.statusline= table.concat({
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

---------------------------------------------------------------
-- Tagbar
---------------------------------------------------------------

-- Start Tagbar
vim.cmd "cnoreabbrev TT TagbarToggle"

-- Allows switching windows without tagbar changing content
vim.cmd "cnoreabbrev Z TagbarTogglePause"

-- Corrects keybinding conflicts within tagbar window
-- Discovered with :verbose map
vim.g.tagbar_map_togglefold = "['za']"
vim.g.tagbar_map_showproto =  "['k']"
vim.g.tagbar_map_togglecaseinsensitive = "['l']"

---------------------------------------------------------------
-- NNN
---------------------------------------------------------------

-- map("t", "-", "<cmd>NnnExplorer<CR>")
-- map("n", "-", "<cmd>NnnExplorer %:p:h<CR>")

---------------------------------------------------------------
-- Telescope
---------------------------------------------------------------

map("n", "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>")
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

---------------------------------------------------------------
-- Markdown
---------------------------------------------------------------

vim.g.vim_markdown_no_default_key_mappings = 1
vim.g.vim_markdown_folding_level = 1
vim.opt.conceallevel = 2

---------------------------------------------------------------
-- Treesitter
---------------------------------------------------------------

require "nvim-treesitter.configs".setup {
	-- A list of parser names, or "all"
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"bash",
		"zig"
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

---------------------------------------------------------------
-- Comment
---------------------------------------------------------------

require("Comment").setup({
    ignore = '^$',
    extra = {
        ---Add comment on the line above
        above = 'gcK',
        ---Add comment on the line below
        below = 'gck',
        ---Add comment at the end of line
        eol = 'gcA',
    },
})

---------------------------------------------------------------
-- Which key
---------------------------------------------------------------

local wk = require("which-key")

wk.register({
    ["n"] = "Left",
    ["N"] = "Next occurence of char",
    ["e"] = "Down",
    ["E"] = "Page down",
    ["i"] = "Up",
    ["I"] = "Page up",
    ["o"] = "Right",
    ["O"] = "Previous occurence of char",
    ["B"] = "Previous end of word",
    ["W"] = "Next end of word",
    -- ["C-H"] = "Move to location of previous motion",
    -- ["C-S-H"] = "Move to location of next motion",
    ["<cr>"] = "which_key_ignore",
})

wk.register({
    ["<leader>"] = {
        d = "Delete without yanking",

        f = {
            name = "+Telescope",
            f = "Find File",
            b = "Buffers",
            g = "Live Grep"
        },

        n = "Go to the left window",
        e = "Go to the window below",
        i = "Go to the window above",
        o = "Go to the right window",

        r = {
            name = "+init.lua editing",
            e = "Edit init.lua",
            r = "Reload init.lua"
        },

        l = "Toggle relative numbers",
        h = {
            name = "+Cursor highlighting",
            l = "Highlight line",
            c = "Highlight column"
        },
        u = "Toggle UndoTree"
    },
    g = {
        l = "Move to last insertion and INSERT",
        e = "Move to next visible line",
        i = "Move to previous visible line",
        h = "Search forwards and select",
        H = "Search backwards and select",
        --n = "which_key_ignore",
        --N = "which_key_ignore"
    }
})

---------------------------------------------------------------
-- Packer
---------------------------------------------------------------

map("", "<leader>u", ":UndotreeToggle<cr>")

require("packer").startup({
    {
        -- Plugin manager
        {
            "wbthomason/packer.nvim"
        },

        -- Color theme
        {
            "w0ng/vim-hybrid"
        },

        -- Comment plugin
        {
            "numToStr/Comment.nvim"
        },

        -- Allows moving through code tags
        {
            "preservim/tagbar",
            cmd = "TagbarToggle"
        },

        -- Enables tab completion
        {
            "ervandew/supertab",
        },

        -- Automatically creates character pairs
        {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup{}
            end
        },

        -- Allows incrementing dates
        {
            "tpope/vim-speeddating",
            requires = { "tpope/vim-repeat" }
        },

        -- Options for surrounding text with special characters
        {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup()
            end
        },

        -- Better syntax highlighting
        {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate"
        },

        -- Shows possible commands for selected key
        {
            "folke/which-key.nvim",
            config = function()
                require("which-key").setup{}
            end
        },

        -- Fuzzy file finder
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.0",
            requires = {"nvim-lua/plenary.nvim"},
            opt = true,
            cmd = "Telescope",
            disable = true
            --config = function()
            --    require("telescope").setup()
            --end
        },

        -- Better behavior in .md files
        {
            "preservim/vim-markdown",
            requires = {"godlygeek/tabular"},
            disable = true
        },

        -- Better searching and replacement
        {
            "tpope/vim-abolish",
            disable = true
        },

        -- Integration with nnn file manager
        {
            "luukvbaal/nnn.nvim",
            opt = true,
            cmd = "NnnExplorer",
            disable = true,
            config = function()
                require("nnn").setup()
            end
        },

        -- Fuzzy file finder
        {
            "nvim-telescope/telescope.nvim",
            tag = "0.1.0",
            requires = {"nvim-lua/plenary.nvim"},
            opt = true,
            cmd = "Telescope",
            disable = true
            --config = function()
            --    require("telescope").setup()
            --end
        },

        -- Better behavior in .md files
        {
            "preservim/vim-markdown",
            requires = {"godlygeek/tabular"},
            disable = true
        },

        -- Graphically shows undo history
        {
            "mbbill/undotree",
            cmd = { "UndotreeToggle", "UndotreeShow" },
            disable = true
        },
    },
    --[[config = {
        display = {
            non_interactive = true
        }
    }]]
})

---------------------------------------------------------------
-- Neovide
---------------------------------------------------------------

-- vim.g.neovide_cursor_animation_length=0.02
-- vim.g.neovide_cursor_vfx_mode = "wireframe"
-- vim.opt.mouse = "a"
-- vim.g.hybrid_custom_term_colors = 1


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
vim.g.maplocalleader = ","

----------------------------------------------------------------
-- Vim settings
----------------------------------------------------------------

-- Enable syntax highlighting
vim.g.syntax = true

-- Enables 24-bit colors
vim.opt.termguicolors = true

-- Sets encoding to UTF-8
vim.opt.encoding = "UTF-8"

-- Sets the font
vim.opt.gfn="Hack 14"

-- Set a color scheme
-- I use https://github.com/w0ng/vim-hybrid with a few tweaks
-- from https://github.com/AlessandroYorba/Alduin
vim.opt.background = "dark"
vim.cmd([[
	colorscheme hybrid
	highlight Search       guifg=#dfdfaf guibg=#878787 gui=NONE ctermfg=187 ctermbg=102  cterm=NONE
	highlight MatchParen   guifg=#dfdfaf guibg=#875f5f gui=NONE ctermfg=187 ctermbg=95   cterm=NONE
	highlight Function     guifg=#af6767 guibg=NONE    gui=NONE ctermfg=95  ctermbg=NONE cterm=NONE
	highlight CursorLineNR guifg=#808890 guibg=NONE    gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
]])

-- Enables persistent undo.
vim.opt.undodir  = "$XDG_STATE_HOME/nvim/undo"
vim.opt.undofile = true

-- Disables swapfiles
vim.opt.swapfile = false

-- Number of lines that remain visible cursor when scrolling
vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 7

-- Disables showing mode on the bottom. Should be obvious from cursor.
vim.opt.showmode = false

-- Visible trailing whitespace
-- See :help lua line 1139
vim.opt.list = true
vim.opt.listchars = {
	trail      = "░",
	tab        = "▸ ",
	extends    = "❱",
	precedes   = "❰",
	nbsp       = "+",
	multispace = "·"
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

--...but not in text files
-- vim.cmd "autocmd FileType markdown,text,plaintex set norelativenumber"

-- Remember position after exiting file
vim.cmd([[
	autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$")
	\ | exe "normal! g'\"" | endif
]])

-- Enable yanking between windows
vim.opt.clipboard="unnamed"

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
--vim.opt.expandtab = true

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

-- Insert mode with newline is now on k
map("", "k", "o")
map("", "K", "O")

---------------------------------------------------------------
-- Custom mappings
---------------------------------------------------------------

-- W and B move to beginning/end of word inclusive
map("", "W", "e")
map("", "B", "gE")

-- Sets N and O for easier horizontal navigation
map("", "N", ",")
map("", "O", ";")

-- E and I function like PageUp/Down
map("", "E", "<C-f>")
map("", "I", "<C-b>")

-- Lower case j joins lines.
map("", "j", "J")

-- Ctrl-D to delete without copying
map("",  "<C-d>", "\"_dd")
map("v", "<C-d>", "\"_d")

-- x and X don't copy when deleting
map("", "x", "\"_x")
map("", "X", "\"_X")

-- Enter clears search highlighting
map("", "<silent><CR>", ":noh<CR>")

-- Easy window switching
map("", "<Left>",  ":wincmd h<CR>")
map("", "<Down>",  ":wincmd j<CR>")
map("", "<Up>",    ":wincmd k<CR>")
map("", "<Right>", ":wincmd l<CR>")

-- Some autoclosing for multi-line stuff
map("i", "{<CR>", "{<CR>}<C-o>O")
map("i", "[<CR>", "[<CR>]<C-o>O")
map("i", "[[<CR>", "[[<CR>]]<C-o>O")
map("i", "/**<CR>", "/**<CR> */<C-o>O * ")

-- Creating newline without insert mode
map("", "<A-k>", "o<Esc>")
map("", "<A-K>", "O<Esc>")

-- Keymaps for working with vimrc
-- Mnemonics: rc edit, rc reload
map("", "<leader>re", ":vsplit $MYVIMRC<cr>")
map("", "<leader>rr", ":source $MYVIMRC<cr>")

-- <leader>l toggles line numbers
map("n", "<leader>l", ":set relativenumber!<CR>")

-- Visual mode pressing * or # searches for the current selection
map("v", "*", ":<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>")

-- Keep visual selection after indent
map('v', '>', '>gv')
map('v', '<', '<gv')
--map('n', '<leader>hl', ':set cursorline!<CR>') -- Leader + h(ighlighting) + l(ine) to toggle highlighting the current line
--map('n', '<leader>hc', ':set cursorcolumn!<CR>') -- Leader + h(ighlighting) + c(olumn) to toggle highlighting the current column

---------------------------------------------------------------
-- Abbreviations
---------------------------------------------------------------

vim.cmd([[
	iabbrev EUR €
	iabbrev GBP £
	iabbrev RUB ₽
	iabbrev ccc ©
	iabbrev tmk ®
	iabbrev --- —
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

---------------------------------------------------------------
-- Plugins
---------------------------------------------------------------

map("t", "-", "<cmd>NnnExplorer<CR>")
map("n", "-", "<cmd>NnnExplorer %:p:h<CR>")

-- Only required if you have packer configured as `opt`
vim.cmd "packadd packer.nvim"

return require('packer').startup(function()
	-- Package manager
	use "wbthomason/packer.nvim"

	-- Easy date increment
	use "tpope/vim-speeddating"

	use "w0ng/vim-hybrid"

	-- Comment plugin
	use {
		"b3nj5m1n/kommentary",
		config = function()
			require("kommentary.config").configure_language(
				"default",
				{prefer_single_line_comments=true}
			)
		end
	}

	-- Delimiter surrounding
	use {
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup()
		end
	}

	-- File manager
	use {
		"luukvbaal/nnn.nvim",
		opt = true,
		cmd = {'NnnExplorer'},
		config = function()
			require("nnn").setup()
		end
	}

	-- Syntax highlighting
	use {
		"nvim-treesitter/nvim-treesitter",
		run = function()
			require("nvim-treesitter.install").update({ with_sync = true })
		end
	}

	-- Better % matching
	-- use {'andymass/vim-matchup', event = 'VimEnter'}

	-- https://github.com/nvim-telescope/telescope.nvim
	-- https://github.com/fhill2/xplr.nvim
	-- https://github.com/phaazon/hop.nvim
	-- https://github.com/neovim/nvim-lspconfig
	-- https://github.com/oberblastmeister/neuron.nvim
	-- https://github.com/nvim-neorg/neorg
	-- https://github.com/tjdevries/colorbuddy.nvim
	-- https://github.com/folke/which-key.nvim
	-- https://github.com/tpope/vim-abolish
	-- https://github.com/mbbill/undotree
	-- https://github.com/TimUntersberger/neogit
	-- https://github.com/lewis6991/gitsigns.nvim
	-- https://github.com/folke/trouble.nvim
	-- https://github.com/shoukoo/commentary.nvim
	-- https://github.com/lewis6991/impatient.nvim
	-- https://github.com/lukas-reineke/indent-blankline.nvim
end)

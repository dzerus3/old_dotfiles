---------------------------------------------------------------
-- Color Scheme
--
-- I use https://github.com/w0ng/vim-hybrid with a few tweaks
-- from https://github.com/AlessandroYorba/Alduin
--
-- Note: This breaks status line colors if declared after it,
-- likely because color theme overwrites them.
--
-- FIXME: Don't make error when theme not installed
-- Investigate:
--   https://github.com/olimorris/dotfiles/tree/main/.config/nvim
--   https://www.reddit.com/r/neovim/comments/puuskh/comment/he5vnqc
---------------------------------------------------------------
vim.opt.background = "dark"
vim.g.hybrid_custom_term_colors = 1
vim.cmd([[
	colorscheme hybrid
	highlight Search
        \ guifg=#dfdfaf
        \ guibg=#878787 
        \ gui=NONE
        \ ctermfg=187
        \ ctermbg=102
        \ cterm=NONE
	highlight MatchParen
        \ guifg=#dfdfaf
        \ guibg=#875f5f
        \ gui=NONE
        \ ctermfg=187
        \ ctermbg=95
        \ cterm=NONE
    highlight Function
        \ guifg=#af6767
        \ guibg=NONE
        \ gui=NONE
        \ ctermfg=95
        \ ctermbg=NONE
        \ cterm=NONE
	highlight CursorLineNR
        \ guifg=#808890
        \ guibg=NONE
        \ gui=NONE
        \ ctermfg=101
        \ ctermbg=NONE
        \ cterm=NONE
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
-- Enables 24-bit colors
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

-- If inside a plaintext file, add word count to status line
vim.cmd([[
	augroup statusline
		autocmd!
		autocmd FileType markdown,text,plaintex
        \ set statusline+=\ w:%{WordCount()}\ \ 
    augroup end
]])

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
-- Telescope
---------------------------------------------------------------

--map("n", "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>")
--map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
--map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

---------------------------------------------------------------
-- Markdown
---------------------------------------------------------------

--vim.g.vim_markdown_no_default_key_mappings = 1
--vim.g.vim_markdown_folding_level = 1
--vim.opt.conceallevel = 2

---------------------------------------------------------------
-- Treesitter
---------------------------------------------------------------

require "nvim-treesitter.configs".setup {
	-- A list of parser names, or "all"
	ensure_installed = {
		"c",
		"lua",
		"rust",
		"bash"
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
        -- TODO: These aren't getting ignored
        --n = "which_key_ignore",
        --N = "which_key_ignore"
    }
})

---------------------------------------------------------------
-- Undotree
---------------------------------------------------------------

map("", "<leader>u", ":UndotreeToggle<cr>")

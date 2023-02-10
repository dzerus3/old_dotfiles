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

-- This function tracks the word count, used for statusline
-- Taken from: https://vim.fandom.com/wiki/Word_count
vim.cmd([[
    let g:word_count=wordcount().words
    function WordCount()
        if has_key(wordcount(),'visual_words')
            let g:word_count=wordcount().visual_words."/".wordcount().words " count selected words
        else
            let g:word_count=wordcount().cursor_words."/".wordcount().words " or shows words 'so far'
        endif
        return g:word_count
    endfunction
]])

-- https://vi.stackexchange.com/questions/36876/see-live-word-count-in-lualine
local function getWords()
    return tostring(vim.fn.wordcount().words)
end

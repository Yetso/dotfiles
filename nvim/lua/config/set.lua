vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching (if smartcase) UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
-- vim.opt.smartcase = true

-- Enable break indent
vim.opt.breakindent = true
vim.opt.wrap = false

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'yes'

vim.opt.iskeyword:append("-")

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

vim.o.hlsearch = true
vim.o.cursorline = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})

vim.opt.laststatus = 3
vim.opt.showcmd = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Tabs for nix files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "nix",
  callback = function()
    vim.opt_local.expandtab = true     -- Use spaces instead of tabs
    vim.opt_local.tabstop = 2          -- Number of spaces a <Tab> counts for
    vim.opt_local.shiftwidth = 2       -- Number of spaces to use for (auto)indent
    vim.opt_local.softtabstop = 2      -- Number of spaces a <Tab> counts for while editing
  end,
})

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.sidescroll = 5
vim.opt.scrolloff = 12

-- vim.opt.confirm = true

vim.diagnostic.config({
	virtual_lines = { current_line = true },
	signs = { text = {
		[vim.diagnostic.severity.ERROR] = '',
		[vim.diagnostic.severity.WARN] = '',
		[vim.diagnostic.severity.INFO] = '',
		[vim.diagnostic.severity.HINT] = '',
	} }
})

vim.opt.guicursor = "n-v-c:block-Cursor,i:ver25-Cursor,r:hor20-Cursor"

-- print checkhealth with float window
vim.g.health = { style = 'float' }

vim.opt.winborder = "rounded"

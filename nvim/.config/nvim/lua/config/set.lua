vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable break indent
vim.opt.breakindent = true
vim.opt.wrap = false

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

vim.opt.iskeyword:append("-")

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.hlsearch = true
vim.o.cursorline = true

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.laststatus = 0
vim.opt.showcmd = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 12

vim.opt.confirm = true

if vim.fn.has("nvim-0.10") == 1 then
	vim.opt.smoothscroll = true
	vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
	vim.opt.foldmethod = "expr"
	vim.opt.foldtext = ""
else
	vim.opt.foldmethod = "indent"
	vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

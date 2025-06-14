-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = "plugins",
	pkg = {
		sources = {
			"lazy",
		},
	},
	rocks = {
		enabled = false,
	},
	install = {
		missing = false,
		colorscheme = { "moonfly" },
	},
	ui = {
		border = "rounded",
	},
	change_detection = {
		enabled = true,
		notify = false,
	},
	checker = { enabled = true, notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

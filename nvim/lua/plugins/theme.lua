return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",
	lazy = false,
	priority = 1000,
	init = function()
		vim.g.moonflyCursorColor = true
		vim.g.moonflyTransparent = true
		vim.g.moonflyNormalFloat = true
		vim.g.moonflyVirtualTextColor = true
		vim.g.moonflyWinSeparator = 2
	end,
	config = function()
		vim.cmd.colorscheme("moonfly")
	end
}

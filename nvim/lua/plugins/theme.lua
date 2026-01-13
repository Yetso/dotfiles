vim.pack.add({
	"https://github.com/bluz71/vim-moonfly-colors",
})
vim.g.moonflyCursorColor = true
vim.g.moonflyTransparent = true
vim.g.moonflyNormalFloat = true
vim.g.moonflyVirtualTextColor = true
vim.g.moonflyWinSeparator = 2

vim.cmd.colorscheme("moonfly")

local ok, _ = pcall(require, "mini.statusline")

if ok then
	vim.api.nvim_set_hl(0, "StatusLine", { bg = "#181818", fg = "#cdcdcd" })
	vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { link = "StatusLine" })
	vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { link = "StatusLine" })
	vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#000000", fg = "#ffffff" })
	vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "#303030", fg = "#dddddd" })
end

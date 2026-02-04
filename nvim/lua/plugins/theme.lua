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
	local palette = require("moonfly").palette
	vim.api.nvim_set_hl(0, "StatusLine", { bg = palette.grey11, fg = palette.grey77 })
	vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { link = "StatusLine" })
	vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { link = "StatusLine" })
	vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = palette.bg, fg = palette.white })
	vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = palette.grey0, fg = palette.white })
end

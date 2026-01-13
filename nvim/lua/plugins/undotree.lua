vim.pack.add({
	"https://github.com/mbbill/undotree",
})

vim.g.undotree_WindowLayout = 2
vim.g.undotree_ShortIndicators = 1
vim.g.undotree_DiffAutoOpen = 0
vim.g.undotree_SetFocusWhenToggle = 1
if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
	vim.g.undotree_DiffCommand = "FC"
end

vim.keymap.set( "n", "<leader>u", vim.cmd.UndotreeToggle, { noremap = true, silent = true })



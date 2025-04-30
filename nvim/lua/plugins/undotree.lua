return {
	"mbbill/undotree",
	init = function()
		vim.g.undotree_WindowLayout = 2
		vim.g.undotree_ShortIndicators = 1
		vim.g.undotree_DiffAutoOpen = 0
		vim.g.undotree_SetFocusWhenToggle = 1
		if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
			vim.g.undotree_DiffCommand = "FC"
		end
	end,
	keys = {
		{ "<leader>u", vim.cmd.UndotreeToggle },
	},
}

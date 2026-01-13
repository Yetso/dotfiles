vim.pack.add({
	"https://github.com/m4xshen/autoclose.nvim",
})

require("autoclose").setup({
	options = {
		disable_when_touch = true,
		disabled_filetypes = { "text", "markdown", "typst" },
	},
})


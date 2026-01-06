return {
	"m4xshen/autoclose.nvim",
	event = "VeryLazy",
	opts = {
		options = {
			disable_when_touch = true,
			disabled_filetypes = { "text", "markdown", "typst" },
		},
	},
}

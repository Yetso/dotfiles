return {
	-- eventuellement mini.comment ?
	"folke/ts-comments.nvim",
	enabled = false,
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring"
	},
	opts = {},
	event = "VeryLazy",
	-- enabled = vim.fn.has("nvim-0.10.0") == 1,
}

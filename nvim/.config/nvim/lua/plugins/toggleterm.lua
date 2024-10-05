return {
	"akinsho/toggleterm.nvim",
	enabled = false,
	lazy = true,
	cmd = {
		"ToggleTerm",
	},
	keys = {
		{ "<C-t>" },
		{ "t", [[<C-\><C-n>]] },
	},
	opts = {
		autochdir = true,
		size = vim.o.lines * 0.25,
		open_mapping = [[<C-t>]],
	},
	init = function ()
		vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {buffer = 0})
	end
}

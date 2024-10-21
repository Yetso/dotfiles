return {
	"smoka7/multicursors.nvim",
	lazy = true,
	dependencies = {
		'nvimtools/hydra.nvim',
	},
	opts = {},
	cmd = { 'MCstart', 'MCvisual', 'MCclear', 'MCpattern', 'MCvisualPattern', 'MCunderCursor' },
	keys = {
		{
			'<Leader>m', '<cmd>MCstart<cr>',
			mode = { 'v', 'n' },
			desc = 'Create a selection for selected text or word under the cursor',
		},
	},
}

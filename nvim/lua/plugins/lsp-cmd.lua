return {
	'saghen/blink.cmp',
	event = "InsertEnter",

	-- optional: provides snippets for the snippet source
	dependencies = { 'rafamadriz/friendly-snippets' },

	-- use a release tag to download pre-built binaries
	version = '1.*',

	opts = {
		keymap = {
			preset = 'enter',
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
		},

		completion = {
			list = {
				selection = { preselect = false, auto_insert = true }
			},
		},
		cmdline = {
			completion = {
				list = { selection = { preselect = false, auto_insert = true } },
				menu = { auto_show = true }
			},
		},
	},
	opts_extend = { "sources.default" }
}

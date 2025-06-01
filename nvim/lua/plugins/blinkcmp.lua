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
				selection = { preselect = false, auto_insert = false }
			},
			menu = {
				border = nil,
				scrolloff = 1,
				scrollbar = false,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label",      "label_description", gap = 1 },
						{ "kind" },
						{ "source_name" },
					},
				},
			},
			documentation = {
				window = {
					border = nil,
					scrollbar = false,
					winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc',
				},
				auto_show = true,
				auto_show_delay_ms = 500,
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

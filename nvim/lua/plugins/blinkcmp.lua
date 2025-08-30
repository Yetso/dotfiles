return {
	"saghen/blink.cmp",
	event = "LspAttach",

	-- optional: provides snippets for the snippet source
	dependencies = { "rafamadriz/friendly-snippets" },

	-- use a release tag to download pre-built binaries
	version = "1.*",

	opts = {
		snippets = {
			jump = function(direction)
				require("blink.cmp").hide()
				vim.snippet.jump(direction)
			end,
		},
		keymap = {
			preset = "none",
			["<C-j>"] = { "select_next", "fallback" },
			["<C-k>"] = { "select_prev", "fallback" },
			['<Up>'] = { 'select_prev', 'fallback' },
			['<Down>'] = { 'select_next', 'fallback' },

			['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
			['<C-e>'] = { 'hide', 'fallback' },

			['<C-n>'] = {'snippet_forward', 'fallback' },
			['<C-p>'] = {'snippet_backward', 'fallback' },

			['<Tab>'] = { 'accept', 'snippet_forward', 'fallback' },
			['<S-Tab>'] = { 'snippet_backward', 'fallback' },
			['<C-CR>'] = { 'accept', 'fallback' },
		},

		completion = {
			list = {
				selection = { preselect = true, auto_insert = false },
			},
			menu = {
				scrolloff = 1,
				scrollbar = true,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label",    "label_description", gap = 1 },
						{ "kind" },
						-- { "source_name" },
					},
				},
			},
			documentation = {
				window = {
					border = nil,
					scrollbar = false,
					winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
				},
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		cmdline = {
			completion = {
				list = { selection = { preselect = true, auto_insert = false } },
				menu = { auto_show = true },
			},
			keymap = {
				preset = "inherit",
			},
		},
	},
	opts_extend = { "sources.default" },
}

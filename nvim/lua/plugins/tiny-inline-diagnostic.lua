return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	opts = {
		transparent_cursorline = true,
		options = {
			use_icons_from_diagnostic = true,
		},
	},
	config = function(_, opts)
		require('tiny-inline-diagnostic').setup(opts)
		vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextArrow", {link = "CursorLine"})
	end,
}

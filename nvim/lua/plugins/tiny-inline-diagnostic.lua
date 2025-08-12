return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "VeryLazy", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	opts = {
		options = {
			use_icons_from_diagnostic = true,
		},
		hi = {
			background = "#1C1C1C",
		},
	},
}

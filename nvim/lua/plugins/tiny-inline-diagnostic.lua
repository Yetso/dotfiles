return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach", -- Or `LspAttach`
	priority = 1000, -- needs to be loaded in first
	opts = {
		options = {
			use_icons_from_diagnostic = true,
		},
		hi = {
			background = "#1C1C1C",
		},
	},
	config = function(_, opts)
		require("tiny-inline-diagnostic").setup(opts)
		vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
		vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextArrow", { bg = "#1C1C1C" })
	end,
}

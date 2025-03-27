return {
	"lewis6991/gitsigns.nvim",
	event = {"BufReadPre", "BufNewFile"},
	config = true,
	keys = {
		{ "<leader>g", "<CMD>Gitsigns preview_hunk<CR>", desc = "Git view changes" },
	},
}

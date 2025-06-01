return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "BufReadPre", "VeryLazy" },
	---@diagnostic disable-next-line: param-type-mismatch
	lazy = vim.fn.argc(-1) == 0 or vim.fn.isdirectory(vim.fn.argv(0)) == 1, --load treesitter early when opening a file from the CMDline
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts_extend = { "ensure_installed" },
	---@diagnostic disable-next-line: missing-fields
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"bash",
			"c",
			"c_sharp",
			"csv",
			"diff",
			"java",
			"json",
			"lua",
			"luadoc",
			"luap",
			"markdown",
			"markdown_inline",
			"nix",
			"nu",
			"python",
			"query",
			"regex",
			"toml",
			"typst",
			"vim",
			"vimdoc",
			"xml",
			"yaml",
		},
	},
	config = function(_, opts)
		vim.filetype.add({
			extension = {
				zsh = "bash",
			},
		})
		require("nvim-treesitter.configs").setup(opts)
	end,
}

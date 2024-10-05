return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0, --load treesitter early when opening a file from the CMDline
	init = function(plugin)
		require("lazy.core.loader").add_to_rtp(plugin)
		require("nvim-treesitter.query_predicates")
	end,
	cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
	opts_extend = { "ensure_installed" },
	---@type TSConfig
	---@diagnostic disable-next-line: missing-fields
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"c",
			"lua",
			"luap",
			"luadoc",
			"regex",
			"vim",
			"vimdoc",
			"query",
			"markdown",
			"markdown_inline",
			"java",
			"python",
			"bash",
			"regex",
			"toml",
			"xml",
			"yaml",
			"diff",
			"json",
		},
	},
	---@param opts TSConfig
	config = function(_, opts)
		vim.filetype.add({
			extension = {
				zsh = 'bash',
			}
		})
		require("nvim-treesitter.configs").setup(opts)
	end,
}

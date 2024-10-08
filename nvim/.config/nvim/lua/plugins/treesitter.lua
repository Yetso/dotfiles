return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = { "VeryLazy" },
	lazy = vim.fn.argc(-1) == 0, --load treesitter early when opening a file from the CMDline
	dependencies = {
		'nvim-treesitter/nvim-treesitter-textobjects',
	},
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
			"nix",
		},
		textobjects = {
			select = {
				enable = true,
				lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
				keymaps = {
					-- You can use the capture groups defined in textobjects.scm
					['af'] = '@function.outer',
					['if'] = '@function.inner',
					['ac'] = '@class.outer',
					['ic'] = '@class.inner',
					['il'] = '@loop.inner',
					['al'] = '@loop.outer',
					['at'] = '@comment.outer',
				},
			},
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

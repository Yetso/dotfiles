return {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		event = 'VimEnter',
		version = false,
		cmd = "Telescope",
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function()
					return vim.fn.executable 'make' == 1
				end,
			},
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc="[F]ind [F]iles"},
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc="[p]roject files (.git)"},
		},
		config = function()
			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup {
				extensions = {
					['ui-select'] = {
						require('telescope.themes').get_dropdown(),
					},
				},
				defaults = {
					path_display = {"truncate"},
				},
				pickers = {
					lsp_references = {
						show_line = false,
					},
					lsp_definitions = {
						show_line = false,
					},
				},
			}

			-- Enable Telescope extensions if they are installed
			require('telescope').load_extension('fzf')
			require('telescope').load_extension('ui-select')
			require('telescope').load_extension('noice')
		end,
	},
}

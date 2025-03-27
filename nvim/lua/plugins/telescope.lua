return {
	{ -- Fuzzy Finder (files, lsp, etc)
		'nvim-telescope/telescope.nvim',
		enabled = false,
		event = 'VimEnter',
		version = false,
		cmd = "Telescope",
		dependencies = {
			'nvim-lua/plenary.nvim',
			-- { -- If encountering errors, see telescope-fzf-native README for installation instructions
			-- 	'nvim-telescope/telescope-fzf-native.nvim',
			-- 	build = 'make',
			-- 	cond = function()
			-- 		return vim.fn.executable 'make' == 1
			-- 	end,
			-- },
			{ 'nvim-telescope/telescope-ui-select.nvim' },

			{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		keys = {
			{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc="[F]ind [F]iles"},
			{ "<C-p>", "<cmd>Telescope git_files<cr>", desc="[p]roject files (.git)"},
			{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc="[F]ind in code"},
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
					layout_strategy = 'vertical',
					path_display = {truncate = 10},
				},
				pickers = {
					lsp_references = {
						show_line = false,
						initial_mode = "normal",
					},
					lsp_definitions = {
						show_line = false,
						initial_mode = "normal",
					},
				},
			}

			-- Enable Telescope extensions if they are installed
			-- require('telescope').load_extension('fzf')
			require('telescope').load_extension('ui-select')
			-- require('telescope').load_extension('noice')
		end,
	},
}

return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		keys = {
			{ "<leader>gf", vim.lsp.buf.format },
		},
		opts = function()
			local null_ls = require("null-ls")
			return {
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.nixpkgs_fmt,
					-- null_ls.builtins.formatting.black,
					-- null_ls.builtins.formatting.isort,
				},
			}
		end,

	},
}

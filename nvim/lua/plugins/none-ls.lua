return {
	{
		"nvimtools/none-ls.nvim",
		keys = {
			{ "<leader>gf", vim.lsp.buf.format },
		},
		opts = function()
			local null_ls = require("null-ls")
			return {
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.google_java_format.with({
						extra_args = {"--set-tabs", "false", "--tab-size", "4"},
					}),
					null_ls.builtins.formatting.nixpkgs_fmt,
					-- null_ls.builtins.formatting.black,
					-- null_ls.builtins.formatting.isort,
				},
			}
		end,

	},
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				-- cmd = { "Mason", "MasonInstall", "MasonUpdate" },
				build = ":MasonUpdate",
				opts = {},
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"stylua",
						"tinymist",
						"google-java-format",
						"jdtls",
						"json-lsp",
						"typstyle",
					}
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
	}
}

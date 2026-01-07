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
						"google-java-format",
						"gopls",
						"jdtls",
						"json-lsp",
						"lua_ls",
						"pylsp",
						"stylua",
						"tinymist",
						-- "typstyle",
					},
				},
			},
		},
	},
	{
		"neovim/nvim-lspconfig",
	},
}

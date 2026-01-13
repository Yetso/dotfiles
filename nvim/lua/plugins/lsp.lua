local lsps = {
	"google-java-format",
	"gopls",
	"hyprls",
	"jdtls",
	"json-lsp",
	"lua-language-server",
	"python-lsp-server",
	"markdown-oxide",
	"stylua",
	"tinymist",
}

return {
	{
		"mason-org/mason-lspconfig.nvim",
		opts = {},
		dependencies = {
			{
				"mason-org/mason.nvim",
				build = ":MasonUpdate",
				opts = {},
				config = function(_, opts)
					require("mason").setup(opts)

					local registry = require("mason-registry")

					for _, pkg in ipairs(lsps) do
						if registry.has_package(pkg) then
							if not registry.is_installed(pkg) then
								vim.cmd("MasonInstall " .. pkg)
							end
						else
							vim.notify("Mason package not found: " .. pkg, vim.log.levels.WARN)
						end
					end
				end,
			},
			{
				"neovim/nvim-lspconfig",
			},
		},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		opts = {
			options = {
				use_icons_from_diagnostic = true,
			},
			hi = {
				background = "#1C1C1C",
			},
		},
		config = function(_, opts)
			require("tiny-inline-diagnostic").setup(opts)
			vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text
			vim.api.nvim_set_hl(0, "TinyInlineDiagnosticVirtualTextArrow", { bg = "#1C1C1C" })
		end,
	},
}


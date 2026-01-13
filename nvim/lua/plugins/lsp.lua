vim.pack.add({
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/mason-org/mason-lspconfig.nvim",
	"https://github.com/rachartier/tiny-inline-diagnostic.nvim",
})

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

require("mason").setup()

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
require("mason-lspconfig").setup()

require("tiny-inline-diagnostic").setup({
	options = {
		use_icons_from_diagnostic = true,
	},
})

vim.diagnostic.config({ virtual_text = false }) -- Disable default virtual text

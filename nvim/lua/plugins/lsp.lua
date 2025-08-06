vim.lsp.enable({
	"jdtls",
	"lua_ls",
	"tinymist",
	"jsonls",
})


vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references({ focus = "list" }) end,
	{ noremap = true, silent = true, desc = "Go to LSP references" })

vim.keymap.set("n", "gre", function() vim.diagnostic.open_float(nil, { focusable = true }) end,
	{ noremap = true, silent = true, desc = "Print LSP messages" })


return {
	{
		"mason-org/mason.nvim",
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				-- "basedpyright",
				-- "google-java-format",
				-- "jdtls",
				"lua-language-server",
			},
		},
	},
}

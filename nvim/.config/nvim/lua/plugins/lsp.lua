return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, --NOTE : must be loaded before dependants
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						"jdtls",
						"pylsp",
						"nil_ls",
					},
				},
			},
		},
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_attach = function(client, bufnr)
				-- Create your keybindings here
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				local telescopeUi = require("telescope.builtin")

				-- Raccourci pour LSP
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>gd", function()
					telescopeUi.lsp_definitions()
				end, bufopts)
				vim.keymap.set("n", "<leader>gr", function()
					telescopeUi.lsp_references()
				end, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
			end
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end,
				["jdtls"] = function()
					require("lspconfig").jdtls.setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
						handlers = {
							["$/progress"] = function(_, result, ctx) end,
						},
					})
				end,
				-- Next, you can provide a dedicated handler for specific servers.
				-- ["lua_ls"] = function()
				-- 	require("luasnip").setup {}
				-- end
			})
		end,
	},
}

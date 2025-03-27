return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{ "williamboman/mason.nvim", config = true }, --NOTE : must be loaded before dependants
			{
				"williamboman/mason-lspconfig.nvim",
				opts = {
					ensure_installed = {
						"lua_ls",
						-- "jdtls",
						-- "pylsp",
						-- "nil_ls",
					},
				},
			},
		},
		config = function()
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_attach = function(_, bufnr)
				-- Create your keybindings here
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				-- local telescopeUi = require("telescope.builtin")

				-- Raccourci pour LSP
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
				vim.keymap.set("n", "<leader>gr", function() Snacks.picker.lsp_references({ focus = 'list' }) end,
					bufopts)
				vim.keymap.set("n", "<leader>gd", function() Snacks.picker.lsp_definitions() end, bufopts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
				vim.keymap.set("n", "E", function()
					vim.diagnostic.open_float(nil, {
						focusable = true,
						border = "rounded"
					})
				end, { desc = "Afficher les erreurs LSP avec une bordure" })
			end
			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler and will
				-- be called for each installed server that doesn't have a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
						flags = {
							debounce_text_changes = 150,
						},
					})
				end,
				-- ["jdtls"] = function()
				-- 	require("lspconfig").jdtls.setup({
				-- 		on_attach = lsp_attach,
				-- 		capabilities = lsp_capabilities,
				-- 		handlers = {
				-- 			["$/progress"] = function(_, result, ctx) end,
				-- 		},
				-- 	})
				-- end,
				["omnisharp"] = function()
					local mason_registry = require("mason-registry")
					local omnisharp_path = mason_registry.get_package("omnisharp"):get_install_path() .. "/omnisharp"

					require("lspconfig").omnisharp.setup({
						cmd = { omnisharp_path }, -- Chemin vers l'exécutable d'OmniSharp
						enable_roslyn_analyzers = true,
						on_attach = lsp_attach,
						capabilities = lsp_capabilities,
					})
				end,
			})
		end,
	},
}

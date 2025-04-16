---@diagnostic disable: undefined-global
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- { "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "luvit-meta/library", words = { "vim%.uv" } },
					},
				},
			},
		},
		config = function()
			-- local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lsp_attach = function(_, bufnr)
				-- Create your keybindings here
				local bufopts = { noremap = true, silent = true, buffer = bufnr }
				-- local telescopeUi = require("telescope.builtin")

				-- Raccourci pour LSP
				vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, bufopts)
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
					})
				end,
				["omnisharp"] = function()
					local mason_registry = require("mason-registry")
					local omnisharp_path = mason_registry.get_package("omnisharp"):get_install_path() .. "/omnisharp"

					require("lspconfig").omnisharp.setup({
						cmd = { omnisharp_path }, -- Chemin vers l'exécutable d'OmniSharp
						enable_roslyn_analyzers = true,
						on_attach = lsp_attach,
					})
				end,
			})
		end,
	},
	{

		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonUpdate" },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"stylua",
				-- "shfmt",
			},
		},

		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			mr:on("package:install:success", function()
				vim.defer_fn(function()
					-- trigger FileType event to possibly load this newly installed LSP server
					require("lazy.core.handler.event").trigger({
						event = "FileType",
						buf = vim.api.nvim_get_current_buf(),
					})
				end, 100)
			end)

			mr.refresh(function()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end)
		end,
	},
}

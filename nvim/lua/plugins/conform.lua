return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>gf",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			-- python = { "isort", "black" },
			-- javascript = { "prettierd", "prettier", stop_after_first = true },
			jsonc = {"jq"},
			java = {"google-java-format"},
		},
		formatters = {
			["google-java-format"] = {
				append_args = {"--aosp"}
			},
		},

	},
}

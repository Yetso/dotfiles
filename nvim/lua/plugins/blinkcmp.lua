vim.keymap.set({ "s", "i" }, "<ESC>", function()
	if vim.snippet and vim.snippet.active() then
		vim.snippet.stop()
	end
	return vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
end, { expr = true })

vim.pack.add({
	{ src = "https://github.com/saghen/blink.cmp",            version = vim.version.range(">1.0.0") },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/folke/lazydev.nvim" },
})

require("lazydev").setup({
	library = {
		-- See the configuration section for more details
		-- Load luvit types when the `vim.uv` word is found
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})

local ok, _ = pcall(require, "lazydev")
local default = { "lsp", "path", "snippets", "buffer" }
if ok then
	table.insert(default, "lazydev")
end

require("blink.cmp").setup({
	sources = {
		-- add lazydev to your completion providers
		default = default,
		per_filetype = {
			sql = { "snippets", "dadbod", "buffer" },
		},
		providers = {
			dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
			lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
		},
	},
	snippets = {
		jump = function(direction)
			require("blink.cmp").hide()
			vim.snippet.jump(direction)
		end,
	},
	keymap = {
		preset = "none",
		["<C-j>"] = { "select_next", "fallback" },
		["<C-k>"] = { "select_prev", "fallback" },
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },

		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
		["<C-e>"] = { "hide", "fallback" },

		["<C-l>"] = { "snippet_forward", "fallback" },
		["<C-h>"] = { "snippet_backward", "fallback" },

		["<Tab>"] = { "accept", "snippet_forward", "fallback" },
		["<S-Tab>"] = { "snippet_backward", "fallback" },
		["<C-CR>"] = { "accept", "fallback" },
	},

	completion = {
		list = {
			selection = { preselect = true, auto_insert = false },
		},
		menu = {
			scrolloff = 1,
			scrollbar = true,
			draw = {
				columns = {
					{ "kind_icon" },
					{ "label",    "label_description", gap = 1 },
					{ "kind" },
				},
			},
		},
		documentation = {
			window = {
				border = nil,
				scrollbar = false,
				winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
			},
			auto_show = true,
			auto_show_delay_ms = 500,
		},
	},
	cmdline = {
		completion = {
			ghost_text = { enabled = false },
			list = { selection = { preselect = true, auto_insert = false } },
			menu = { auto_show = true },
		},
		keymap = {
			preset = "inherit",
		},
	},
})

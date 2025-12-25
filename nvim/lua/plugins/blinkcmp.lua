-- vim.keymap.set("i", "<C-j>", [[pumvisible() ? "\<C-n>" : "\<C-j>"]], { expr = true })
-- vim.keymap.set("i", "<C-k>", [[pumvisible() ? "\<C-p>" : "\<C-k>"]], { expr = true })

return {
	"saghen/blink.cmp",
	-- event = "LspAttach",

	-- optional: provides snippets for the snippet source
	-- dependencies = { "rafamadriz/friendly-snippets" },
	dependencies = {
		{ "rafamadriz/friendly-snippets" },
		-- {
		-- 	"L3MON4D3/LuaSnip",
		-- 	version = "v2.*",
		-- 	config = function()
		-- 		require("luasnip.loaders.from_vscode").lazy_load()
		-- 		require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
		-- 	end,
		-- },
	},

	-- use a release tag to download pre-built binaries
	version = "1.*",

	opts = {
		sources = {
			-- add lazydev to your completion providers
			default = { "lazydev", "lsp", "path", "snippets", "buffer" },
			per_filetype = {
				sql = { "snippets", "dadbod", "buffer" },
			},
			providers = {
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
			},
		},
		snippets = {
			-- preset = "luasnip",
			-- jump = function(direction)
			-- 	require("blink.cmp").hide()
			-- 	vim.snippet.jump(direction)
			-- end,
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
			-- ghost_text = {
			-- 	enabled = true,
			-- },
			menu = {
				scrolloff = 1,
				scrollbar = true,
				draw = {
					columns = {
						{ "kind_icon" },
						{ "label", "label_description", gap = 1 },
						{ "kind" },
						-- { "source_name" },
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
				list = { selection = { preselect = true, auto_insert = false } },
				menu = { auto_show = true },
			},
			keymap = {
				preset = "inherit",
			},
		},
	},
	opts_extend = { "sources.default" },
	-- "nvim-mini/mini.completion",
	-- -- event = "LspAttach",
	-- dependencies = {
	-- 	"nvim-mini/mini.snippets",
	-- 	"nvim-mini/mini.icons",
	-- },
	--
	--
	--
	-- opts = {
	-- 	-- No need to copy this inside `setup()`. Will be used automatically.
	-- 	-- Delay (debounce type, in ms) between certain Neovim event and action.
	-- 	-- This can be used to (virtually) disable certain automatic actions by
	-- 	-- setting very high delay time (like 10^7).
	-- 	delay = { completion = 100, info = 100, signature = 50 },
	--
	-- 	-- Configuration for action windows:
	-- 	-- - `height` and `width` are maximum dimensions.
	-- 	-- - `border` defines border (as in `nvim_open_win()`; default "single").
	-- 	window = {
	-- 		info = { height = 25, width = 80, border = nil },
	-- 		signature = { height = 25, width = 80, border = nil },
	-- 	},
	--
	-- 	-- Way of how module does LSP completion
	-- 	lsp_completion = {
	-- 		-- `source_func` should be one of 'completefunc' or 'omnifunc'.
	-- 		source_func = "omnifunc",
	--
	-- 		-- `auto_setup` should be boolean indicating if LSP completion is set up
	-- 		-- on every `BufEnter` event.
	-- 		auto_setup = true,
	--
	-- 		-- A function which takes LSP 'textDocument/completion' response items
	-- 		-- (each with `client_id` field for item's server) and word to complete.
	-- 		-- Output should be a table of the same nature as input. Common use case
	-- 		-- is custom filter/sort. Default: `default_process_items`
	-- 		process_items = nil,
	--
	-- 		-- A function which takes a snippet as string and inserts it at cursor.
	-- 		-- Default: `default_snippet_insert` which tries to use 'mini.snippets'
	-- 		-- and falls back to `vim.snippet.expand` (on Neovim>=0.10).
	-- 		snippet_insert = nil,
	-- 	},
	--
	-- 	-- Fallback action as function/string. Executed in Insert mode.
	-- 	-- To use built-in completion (`:h ins-completion`), set its mapping as
	-- 	-- string. Example: set '<C-x><C-l>' for 'whole lines' completion.
	-- 	fallback_action = "<C-n>",
	--
	-- 	-- Module mappings. Use `''` (empty string) to disable one. Some of them
	-- 	-- might conflict with system mappings.
	-- 	mappings = {
	-- 		-- Force two-step/fallback completions
	-- 		force_twostep = "<C-Space>",
	-- 		force_fallback = "<A-Space>",
	--
	-- 		-- Scroll info/signature window down/up. When overriding, check for
	-- 		-- conflicts with built-in keys for popup menu (like `<C-u>`/`<C-o>`
	-- 		-- for 'completefunc'/'omnifunc' source function; or `<C-n>`/`<C-p>`).
	-- 		scroll_down = "<C-f>",
	-- 		scroll_up = "<C-b>",
	-- 	},
	-- },
	-- config = function(_, opts)
	-- 	require("mini.completion").setup(opts)
	-- end,
}

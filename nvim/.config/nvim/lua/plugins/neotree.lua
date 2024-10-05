return {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{
			"<leader>n", "<cmd>Neotree<cr>",
			-- function()
			-- 	require("neo-tree.command").execute({ toggle = false, dir = vim.uv.cwd() })
			-- end,
			desc = "Explorer NeoTree (cwd)",
		},
		{
			"<leader>be", "<cmd>Neotree source=buffers toggle=false<cr>",
			-- function()
			-- 	require("neo-tree.command").execute({ source = "buffers", toggle = false })
			-- end,
			desc = "Buffer Explorer",
		},
	},
	init = function()
		-- FIX: use `autocmd` for lazy-loading neo-tree instead of directly requiring it,
		-- because `cwd` is not set up properly.
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("Neotree_start_directory", { clear = true }),
			desc = "Start Neo-tree with directory",
			once = true,
			callback = function()
				if package.loaded["neo-tree"] then
					return
				else
					local stats = vim.uv.fs_stat(vim.fn.argv(0))
					if stats and stats.type == "directory" then
						require("neo-tree")
					end
				end
			end,
		})
	end,
	opts = {
		sources = { "filesystem", "buffers" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
		filesystem = {
			filtered_items = {
				visible = false,
				never_show = {
					".DS_Store",
				},
			},
			bind_to_cwd = true,
			follow_current_file = { enabled = true },
			use_libuv_file_watcher = true,
		},
		window = {
			mappings = {
				["l"] = "open",
				["h"] = "close_node",
				["<space>"] = "none",
				["Y"] = {
					function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						vim.fn.setreg("+", path, "c")
					end,
					desc = "Copy Path to Clipboard",
				},
				["P"] = { "toggle_preview", config = { use_float = true } },
			},
		},
		default_component_configs = {
			indent = {
				with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
				expander_collapsed = "",
				expander_expanded = "",
				expander_highlight = "NeoTreeExpander",
				indent_size = 1,
			},
			modified = {
				symbol = "",
			},
		},
		config = function(_, opts)
			local function on_move(data)
				if vim.lsp.buf.server_reday() then
					vim.lsp.on_rename(data.source, data.destination)
				else
					vim.notify("LSP not set to rename", vim.log.levels.INFO)
				end
			end

			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED,   handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
			require("neo-tree").setup(opts)
		end
	}
}

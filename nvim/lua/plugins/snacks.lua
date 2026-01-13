vim.pack.add({
	"https://github.com/folke/snacks.nvim",
})

local function is_git_repo()
	local git_dir = vim.fn.finddir(".git", ".;")
	return git_dir ~= ""
end

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
	---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params
		.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
		if not client or type(value) ~= "table" then
			return
		end
		local p = progress[client.id]

		for i = 1, #p + 1 do
			if i == #p + 1 or p[i].token == ev.data.params.token then
				p[i] = {
					token = ev.data.params.token,
					msg = ("[%3d%%] %s%s"):format(
						value.kind == "end" and 100 or value.percentage or 100,
						value.title or "",
						value.message and (" **%s**"):format(value.message) or ""
					),
					done = value.kind == "end",
				}
				break
			end
		end

		local msg = {} ---@type string[]
		progress[client.id] = vim.tbl_filter(function(v)
			return table.insert(msg, v.msg) or not v.done
		end, p)

		-- local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		local spinner = { "◜", "◝", "◞", "◟" }

		vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 150)) % #spinner + 1]
			end,
		})
	end,
})

require("snacks").setup({
	statuscolumn = {
		enabled = true,
		left = { "sign", "mark" }, -- priority of signs on the left (high to low)
		right = { "fold", "git" }, -- priority of signs on the right (high to low)
		folds = {
			open = true,     -- show open fold icons
			git_hl = false,  -- use Git Signs hl for fold icons
		},
		git = {
			patterns = { "GitSign", "MiniDiffSign" },
		},
		refresh = 500,
	},
	git = { enabled = false },
	lazygit = {
		enabled = true,
		configure = false,
	},
	quickfile = { enabled = true },
	dashboard = { enabled = false },
	indent = { enabled = true },
	image = {
		enabled = true,
		doc = {
			inline = false,
			float = false,
		},
	},
	input = {
		enabled = true,
	},
	notifier = {
		enabled = true,
		refresh = 100,
	},
	notify = { enabled = true },

	explorer = {
		enabled = true,
		replace_netrw = true,
	},
	picker = {
		enabled = true,
		focus = "list",
		icons = {
			tree = {
				vertical = "│",
				middle = "├",
				last = "└",
			},
			diagnostics = {
				Error = "󰅜 ",
				Warn = " ",
				Hint = " ",
				Info = " ",
			},
		},
		sources = {
			files = {
				exclude = { "*.meta" },
				include = { ".gitignore" },
				follow = true,
			},
			explorer = {
				exclude = { "*.meta" },
				include = { ".gitignore" },
				ignored = true,
				win = {
					list = {
						keys = {
							---@diagnostic disable-next-line: assign-type-mismatch
							["<Esc>"] = { { "select_all", "select_all" } },
						},
					},
				},
			},
		},
		win = {
			input = {
				keys = {
					-- ["<CR>"] = { "toggle_focus", mode = { "i", "n" } },
					["l"] = { "confirm" },
					["/"] = false,
				},
			},
			list = {
				keys = {
					["<C-p>"] = false,
					["f"] = false,
				},
			},
		},
	},

	scroll = { enabled = false },
	scope = { enabled = false },
	words = { enabled = false },
	bigfile = { enabled = false },
})

local ok, Snacks = pcall(require, "snacks")
if not ok then
	return
end

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>lg", function()
	Snacks.lazygit()
end, vim.tbl_extend("force", opts, { desc = "Lazygit" }))

-- Lazygit log
vim.keymap.set("n", "<leader>gl", function()
	Snacks.lazygit.log()
end, vim.tbl_extend("force", opts, { desc = "Lazygit [G]it [L]og" }))

-- File explorer toggle / focus
vim.keymap.set("n", "<leader>n", function()
	local explorer = Snacks.picker.get({ source = "explorer" })[1]

	if explorer == nil then
		Snacks.picker.explorer()
	elseif not explorer:is_focused() then
		explorer:focus()
	end
end, vim.tbl_extend("force", opts, { desc = "File Explorer" }))

-- Find files (git-aware)
vim.keymap.set("n", "<C-p>", function()
	if is_git_repo() then
		Snacks.picker.git_files({
			focus = "input",
			layout = { preset = "select" },
		})
	else
		Snacks.picker.files({
			focus = "input",
			layout = { preset = "select" },
		})
	end
end, vim.tbl_extend("force", opts, { desc = "Find Git Files" }))

-- Notification history
vim.keymap.set("n", "<leader>h", function()
	Snacks.notifier.show_history()
end, vim.tbl_extend("force", opts, { desc = "[H]istory" }))

-- Find files
vim.keymap.set("n", "<leader>ff", function()
	Snacks.picker.files({
		focus = "input",
		layout = { preset = "select" },
	})
end, vim.tbl_extend("force", opts, { desc = "[F]ind [F]iles" }))

-- Live grep
vim.keymap.set("n", "<leader>fg", function()
	Snacks.picker.grep({ focus = "input" })
end, vim.tbl_extend("force", opts, { desc = "[F]ind in code" }))

-- Diagnostics (current buffer)
vim.keymap.set("n", "<leader>d", function()
	Snacks.picker.diagnostics_buffer({ focus = "list" })
end, vim.tbl_extend("force", opts, { desc = "Go to [D]iagnostic window" }))

-- Terminal toggle (normal / insert / terminal)
vim.keymap.set({ "n", "i", "t" }, "<C-t>", function()
	local terminal = Snacks.terminal.list()[1]

	if terminal == nil then
		Snacks.terminal()
	elseif not vim.api.nvim_win_is_valid(terminal.win) then
		Snacks.terminal()
	else
		vim.api.nvim_set_current_win(terminal.win)
		vim.cmd("hide")
		vim.cmd("stopinsert")
	end
end, vim.tbl_extend("force", opts, { desc = "[T]erminal" }))

vim.keymap.set("n", "<leader>q", function()
	Snacks.bufdelete()
end, vim.tbl_extend("force", opts, { desc = "[B]uffer [C]lose" }))
-- local buffer_keys = {}

vim.keymap.set("n", "<leader>bca", function()
	Snacks.bufdelete.other()
end, vim.tbl_extend("force", opts, { desc = "[B]uffer [C]lose [A]ll" }))


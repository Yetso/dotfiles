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

		local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
		vim.notify(table.concat(msg, "\n"), vim.log.levels.INFO, {
			id = "lsp_progress",
			title = client.name,
			opts = function(notif)
				notif.icon = #progress[client.id] == 0 and " "
					or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
			end,
		})
	end,
})

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		statuscolumn = {
			enabled = true,
			left = { "mark", "sign" }, -- priority of signs on the left (high to low)
			right = { "fold", "git" }, -- priority of signs on the right (high to low)
			folds = {
				open = true,  -- show open fold icons
				git_hl = false, -- use Git Signs hl for fold icons
			},
			git = {
				patterns = { "GitSign", "MiniDiffSign" },
			},
			refresh = 500,
		},
		git = { enabled = false },
		lazygit = {
			enabled = true,
			-- configure = false,
		},
		quickfile = { enabled = true },
		dashboard = { enabled = true },
		indent = { enabled = true },
		image = { enabled = true },
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
			sources = {
				explorer = {
					git_status_open = true,
					-- diagnostic_open = true,
				},
			},
			win = {
				list = {
					keys = {
						["<C-p>"] = false,
						["f"] = false,
					},
				},
			},
		},

		trouble = { enabled = true },

		scope = { enabled = false },
		scroll = { enabled = false },
		words = { enabled = false },
		bigfile = { enabled = false },
	},
	keys = {
		{ "<leader>lg", function() Snacks.lazygit() end,     desc = "Lazygit" },
		{ "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit [G]it [L]og" },
		{
			"<leader>n",
			function()
				if Snacks.picker.get({ source = "explorer" })[1] == nil then
					Snacks.picker.explorer()
				elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == true then
					Snacks.picker.explorer()
				elseif Snacks.picker.get({ source = "explorer" })[1]:is_focused() == false then
					Snacks.picker.get({ source = "explorer" })[1]:focus()
				end
			end,
			desc = "File Explorer"
		},
		{
			"<C-p>",
			function()
				if is_git_repo() then
					Snacks.picker.git_files()
				else
					Snacks.picker.files()
				end
			end,
			desc = "Find Git Files"
		},
		{ "<leader>h",  function() Snacks.notifier.show_history() end,                       desc = "[H]istory" },
		{ "<leader>ff", function() Snacks.picker.files() end,                                desc = "[F]ind [F]iles" },
		{ "<leader>fg", function() Snacks.picker.grep() end,                                 desc = "[F]ind in code" },
		{ "<leader>gr", function() Snacks.picker.lsp_references({ focus = "list" }) end,     desc = "[G]o to [R]eferences" },
		{ "<leader>gd", function() Snacks.picker.lsp_definitions() end,                      desc = "[G]o to [D]efinitions" },
		{ "<leader>d",  function() Snacks.picker.diagnostics_buffer({ focus = "list" }) end, desc = "[G]o to [D]efinitions" },
	},
}

vim.api.nvim_create_autocmd('BufEnter', {
	callback = vim.schedule_wrap(function()
		local n_listed_bufs = 0
		for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
			if vim.fn.buflisted(buf_id) == 1 then n_listed_bufs = n_listed_bufs + 1 end
		end

		vim.o.showtabline = n_listed_bufs > 1 and 2 or 0
	end),
	desc = 'Update tabline based on the number of listed buffers',
})

local format_summary = function(data)
	local summary = vim.b[data.buf].minidiff_summary
	if not summary then return end
	if not (summary.add and summary.change and summary.delete) then
		return
	end

	local t = {}
	if summary.add > 0 then table.insert(t, '%#GitSignsAdd#+' .. summary.add) end
	if summary.change > 0 then table.insert(t, '%#GitSignsChange#~' .. summary.change) end
	if summary.delete > 0 then table.insert(t, '%#GitSignsDelete#-' .. summary.delete) end
	vim.b[data.buf].minidiff_summary_string = table.concat(t, ' ')
end
local au_opts = { pattern = 'MiniDiffUpdated', callback = format_summary }
vim.api.nvim_create_autocmd('User', au_opts)

local buffer_keys = {}
for i = 1, 9 do
	table.insert(buffer_keys, {
		"<leader>" .. i,
		function()
			local buflist = vim.fn.getbufinfo({ buflisted = 1 })
			if buflist[i] ~= nil then
				vim.cmd('buffer ' .. buflist[i].bufnr)
			end
		end,
		desc = "Buffer " .. i,
	})
end
table.insert(buffer_keys, { "<S-q>", function() Snacks.bufdelete() end, desc = "[B]uffer [C]lose" })
table.insert(buffer_keys, { "<leader>bac", function() Snacks.bufdelete.other() end, desc = "[B]uffer [A]ll [C]lose" })
table.insert(buffer_keys, { "H", "<cmd>bprevious<cr>", desc = "Prev Buffer" })
table.insert(buffer_keys, { "L", "<cmd>bnext<cr>", desc = "Next Buffer" })

---@diagnostic disable: undefined-global
return {
	{
		"echasnovski/mini.icons",
		version = false,
		opts = {},
		init = function()
			package.preload["nvim-web-devicons"] = function()
				require("mini.icons").mock_nvim_web_devicons()
				return package.loaded["nvim-web-devicons"]
			end
		end,
	},
	{
		'echasnovski/mini.cursorword',
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		opts = {},

	},
	{
		"echasnovski/mini.diff",
		version = false,
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{
				"<leader>g",
				function()
					require("mini.diff").toggle_overlay(0)
				end,
				desc = "Toggle mini.diff overlay",
			},
		},
		opts = {
			view = {
				style = "sign",
				signs = {
					add = "▎",
					change = "▎",
					delete = "▁",
				},
			},
		},
	},
	{
		"echasnovski/mini.move",
		event = { "BufReadPre", "BufNewFile" },
		version = false,
		opts = {},

	},
	{
		"echasnovski/mini.tabline",
		version = false,
		event = "VeryLazy",
		opts = {
			format = function(buf_id, label)
				local buflist = vim.fn.getbufinfo({ buflisted = 1 })
				local prefix = nil
				for i, b in ipairs(buflist) do
					if b.bufnr == buf_id then
						prefix = ' ' .. i
						break
					end
				end

				local suffix = vim.bo[buf_id].modified and '[+]' or ''
				return prefix .. MiniTabline.default_format(buf_id, label) .. suffix
			end
		},
		config = function(_, opts)
			require("mini.tabline").setup(opts)
			vim.o.showtabline = 0
		end,
		keys = buffer_keys,
	},
	{
		"echasnovski/mini.statusline",
		version = false,
		config = function(_, opts)
			require("mini.statusline").setup(opts)
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "#181818", fg = "#cdcdcd" })
			vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { link = "Statusline" })
			vim.api.nvim_set_hl(0, "MiniStatuslineFileinfo", { link = "Statusline" })
			vim.api.nvim_set_hl(0, "MiniStatuslineInactive", { bg = "#000000", fg = "#ffffff" })
			vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = "#303030", fg = "#dddddd" })
		end,
		opts = {
			content = {
				active = function()
					local diag_signs    = {
						ERROR = '%#DiagnosticError#󰅜',
						WARN = '%#DiagnosticWarn#',
						INFO = '%#DiagnosticInfo#',
						HINT = '%#DiagnosticHint#',
					}

					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 1 })
					local diff          = vim.b.minidiff_summary_string or ""
					local filename      = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
					if filename == "" then
						filename = "[No Name]"
					end
					local fileinfo    = MiniStatusline.section_fileinfo({ trunc_width = 9999 })
					local diagnostics = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						signs = diag_signs,
						icon = ""
					})
					diagnostics       = diagnostics .. '%#MiniStatuslineDevinfo#'
					local line        = vim.fn.line(".")
					local percent     = math.floor(line / vim.fn.line("$") * 100) .. "%%"
					local location    = line .. ':' .. vim.fn.col(".")
					local lazyUpdate  = require("lazy.status")
					local lazyScreen  = lazyUpdate.has_updates() and lazyUpdate.updates() or ""
					local recording = vim.fn.reg_recording() ~= "" and "%#MoonflyRed#recording @ " .. vim.fn.reg_recording() or ""

					return MiniStatusline.combine_groups({
						{ hl = mode_hl,                  strings = { mode } },
						"%<",
						{ hl = 'MiniStatuslineFilename', strings = { filename } },
						{ hl = 'MiniStatuslineDevinfo',  strings = { diff, diagnostics } },
						'%=', -- End left alignment
						{ hl = 'MoonflyRed', strings = { lazyScreen } },
						{ hl = 'MiniStatuslineFileinfo', strings = { recording } },
						{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
						{ hl = 'MiniStatuslineFilename', strings = { percent } },
						{ hl = mode_hl,                  strings = { location } },
					})
				end,
			},
		},
	},
}

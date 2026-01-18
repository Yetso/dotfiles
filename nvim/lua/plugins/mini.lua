vim.api.nvim_create_autocmd("BufEnter", {
	callback = vim.schedule_wrap(function()
		local n_listed_bufs = 0
		for _, buf_id in ipairs(vim.api.nvim_list_bufs()) do
			if vim.fn.buflisted(buf_id) == 1 then
				n_listed_bufs = n_listed_bufs + 1
			end
		end

		vim.o.showtabline = n_listed_bufs > 1 and 2 or 0
	end),
	desc = "Update tabline based on the number of listed buffers",
})

local format_summary = function(data)
	local summary = vim.b[data.buf].minidiff_summary
	if not summary then
		return
	end
	if not (summary.add and summary.change and summary.delete) then
		return
	end

	local t = {}
	if summary.add > 0 then
		table.insert(t, "%#GitSignsAdd#+" .. summary.add)
	end
	if summary.change > 0 then
		table.insert(t, "%#GitSignsChange#~" .. summary.change)
	end
	if summary.delete > 0 then
		table.insert(t, "%#GitSignsDelete#-" .. summary.delete)
	end
	vim.b[data.buf].minidiff_summary_string = table.concat(t, " ")
end
local au_opts = { pattern = "MiniDiffUpdated", callback = format_summary }
vim.api.nvim_create_autocmd("User", au_opts)

vim.pack.add({
	"https://github.com/nvim-mini/mini.icons",
	"https://github.com/nvim-mini/mini.cursorword",
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/nvim-mini/mini.diff",
	"https://github.com/nvim-mini/mini.tabline",
	"https://github.com/nvim-mini/mini.statusline",
})

---@diagnostic disable-next-line: duplicate-set-field
package.preload["nvim-web-devicons"] = function()
	require("mini.icons").mock_nvim_web_devicons()
	return package.loaded["nvim-web-devicons"]
end
require("mini.cursorword").setup()
require("mini.surround").setup({
	mappings = {
		add = "sa", -- Add surrounding in Normal and Visual modes
		delete = "sd", -- Delete surrounding
		find = "", -- Find surrounding (to the right)
		find_left = "", -- Find surrounding (to the left)
		highlight = "", -- Highlight surrounding
		replace = "", -- Replace surrounding

		suffix_last = "", -- Suffix to search with "prev" method
		suffix_next = "", -- Suffix to search with "next" method
	},
})
require("mini.diff").setup({
	view = {
		style = "sign",
		signs = {
			add = "▎",
			change = "▎",
			delete = "▁",
		},
	},
})

require("mini.tabline").setup({
	format = function(buf_id, label)
		local buflist = vim.fn.getbufinfo({ buflisted = 1 })
		local prefix = nil
		for i, b in ipairs(buflist) do
			if b.bufnr == buf_id then
				prefix = " " .. i
				break
			end
		end

		local suffix = vim.bo[buf_id].modified and "[+]" or ""
		return prefix .. MiniTabline.default_format(buf_id, label) .. suffix
	end,
})
vim.o.showtabline = 0

local opts = { noremap = true, silent = true }

for i = 1, 9 do
	vim.keymap.set("n", "<leader>" .. i, function()
		local buflist = vim.fn.getbufinfo({ buflisted = 1 })
		if buflist[i] ~= nil then
			vim.cmd("buffer " .. buflist[i].bufnr)
		end
	end, vim.tbl_extend("force", opts, { desc = "Go to buffer " .. i }))
end

vim.keymap.set("n", "H", "<cmd>bprevious<cr>", vim.tbl_extend("force", opts, { desc = "Prev Buffer" }))
vim.keymap.set("n", "L", "<cmd>bnext<cr>", vim.tbl_extend("force", opts, { desc = "Next Buffer" }))

require("mini.statusline").setup({
	content = {
		active = function()
			local diag_signs = {
				ERROR = "%#DiagnosticError#󰅜",
				WARN = "%#DiagnosticWarn#",
				INFO = "%#DiagnosticInfo#",
				HINT = "%#DiagnosticHint#",
			}

			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 1 })
			local diff = vim.b.minidiff_summary_string or ""
			local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":.")
			if filename == "" then
				filename = "[No Name]"
			end
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 9999 })
			local diagnostics = MiniStatusline.section_diagnostics({
				trunc_width = 75,
				signs = diag_signs,
				icon = "",
			})
			diagnostics = diagnostics .. "%#MiniStatuslineDevinfo#"
			local line = vim.fn.line(".")
			local percent = math.floor(line / vim.fn.line("$") * 100) .. "%%"
			local location = line .. ":" .. vim.fn.col(".")
			-- local lazyUpdate = require("lazy.status")
			-- local lazyScreen = lazyUpdate.has_updates() and lazyUpdate.updates() or ""
			local recording = vim.fn.reg_recording() ~= "" and "%#MoonflyRed#recording @ " .. vim.fn.reg_recording()
				or ""

			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				{ hl = "MiniStatuslineDevinfo", strings = { diff, diagnostics } },
				"%=", -- End left alignment
				-- { hl = "MoonflyRed", strings = { lazyScreen } },
				{ hl = "MiniStatuslineFileinfo", strings = { recording } },
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = "MiniStatuslineFilename", strings = { percent } },
				{ hl = mode_hl, strings = { location } },
			})
		end,
	},
})

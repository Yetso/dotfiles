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
table.insert(buffer_keys, { "<leader>bc", function() Snacks.bufdelete() end, desc = "[B]uffer [C]lose" })
table.insert(buffer_keys, { "<S-h>", "<cmd>bprevious<cr>", desc = "Prev Buffer" })
table.insert(buffer_keys, { "<S-l>", "<cmd>bnext<cr>", desc = "Next Buffer" })

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
		'echasnovski/mini.tabline',
		version = false,
		event = "VeryLazy",
		opts = {
			format = function(buf_id, label)
				local buflist = vim.fn.getbufinfo({ buflisted = 1 })
				local prefix = nil
				for i, b in ipairs(buflist) do
					if b.bufnr == buf_id then
						prefix = i
						break
					end
				end

				local suffix = vim.bo[buf_id].modified and '+ ' or ''
				return prefix .. MiniTabline.default_format(buf_id, label) .. suffix
			end
		},
		keys = buffer_keys,
	},
	{
		"echasnovski/mini.statusline",
		enabled = false,
		version = false,
		opts = {
			content = {
				active = function()
					local diag_signs    = { ERROR = "󰅜", WARN = '', INFO = '', HINT = '' }

					local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
					local filename      = MiniStatusline.section_filename({ trunc_width = 0 })
					-- local git           = MiniStatusline.section_git({ trunc_width = 40 })
					local diff          = MiniStatusline.section_diff({ trunc_width = 75, icon = "󰊢" })
					local diagnostics   = MiniStatusline.section_diagnostics({
						trunc_width = 75,
						signs = diag_signs,
						icon =
						""
					})
					-- local lsp           = MiniStatusline.section_lsp({ trunc_width = 75 })
					local fileinfo      = MiniStatusline.section_fileinfo({ trunc_width = 120 })
					local location      = MiniStatusline.section_location({ trunc_width = 9999 })

					return MiniStatusline.combine_groups({
						{ hl = mode_hl,                  strings = { mode } },
						{ hl = 'MiniStatuslineFilename', strings = { filename } },
						'%<', -- Mark general truncate point
						{ hl = 'MiniStatuslineDevinfo',  strings = { diff, diagnostics } },
						-- { hl = 'MiniStatuslineDevinfo', strings = { git, diff, diagnostics, lsp } },
						'%=', -- End left alignment
						{ hl = 'MiniStatuslineFileinfo', strings = { fileinfo } },
						{ hl = mode_hl,                  strings = { location } },
					})
				end,
			},
		},
	},
}


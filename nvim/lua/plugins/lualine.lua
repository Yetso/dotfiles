return {
	"nvim-lualine/lualine.nvim",
	-- enabled = false,
	event = "VeryLazy",
	-- dependencies = {
	-- 	"nvim-tree/nvim-web-devicons",
	-- },
	opts = {
		options = {
			theme = "moonfly",
			globalstatus = true,
			always_show_tabline = false,
		},
		extensions = {
			"lazy",
			"mason"
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = {
				{
					-- Customize the filename part of lualine to be parent/filename
					"filename",
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 1, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory
				},
			},
			lualine_c = {
				{ "diff" },
				{
					"diagnostics",
					symbols = { error = '󰅜', warn = '', info = '', hint = '' },
				},
			},

			lualine_x = {
				{
					function()
						return "recording @ " .. vim.fn.reg_recording()
					end,
					cond = function()
						if vim.fn.reg_recording() == "" then return false end
						return true
					end,
					color = { fg = "#ff9e64" },
				},
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff0000" }
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
			lualine_y = { "progress" },
			lualine_z = { "location" }
		},
	},
}

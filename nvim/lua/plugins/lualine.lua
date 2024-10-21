return {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"folke/noice.nvim",
		-- "linrongbin16/lsp-progress.nvim",
	},
	opts = {
		options = {
			theme = "moonfly",
			globalstatus = true,
		},
		extensions = {
			"nvim-tree",
			"lazy",
			"toggleterm",
			"fugitive",
		},
		sections = {
			lualine_c = {
				{
					-- Customize the filename part of lualine to be parent/filename
					'filename',
					file_status = true, -- Displays file status (readonly status, modified status)
					newfile_status = false, -- Display new file status (new file means no write after created)
					path = 4, -- 0: Just the filename
					-- 1: Relative path
					-- 2: Absolute path
					-- 3: Absolute path, with tilde as the home directory
					-- 4: Filename and parent dir, with tilde as the home directory
					symbols = {
						modified = '[+]', -- Text to show when the file is modified.
						readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
					}
				}
			},
			lualine_x = {
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = {fg = "#ff0000"}
				},
				{
---@diagnostic disable-next-line: undefined-field
					require("noice").api.status.mode.get,
---@diagnostic disable-next-line: undefined-field
					cond = require("noice").api.status.mode.has,
					color = { fg = "#ff9e64" },
				},
				{ "encoding" },
				{ "fileformat" },
				{ "filetype" },
			},
		},
	},
}

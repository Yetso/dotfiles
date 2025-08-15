return {
	"folke/noice.nvim",
	-- event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
		{
			-- "rcarriga/nvim-notify",
			-- opts = {
			-- 	background_colour = "#000000",
			-- },
		},
	},
	opts = {
		notify = {
			enabled = false,
		},
		lsp = {
			progress = {
				enabled = false,
			},
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		presets = {
			bottom_search = true,
			command_palette = true,
			long_message_to_split = true,
			lsp_doc_border = true,
		},
		-- routes = {
		-- 	{
		-- 		filter = {
		-- 			event = "msg_show",
		-- 			any = {
		-- 				{ find = "%d+L, %d+B written" },
		-- 				{ find = "; after #%d+" },
		-- 				{ find = "; before #%d+" },
		-- 				{ find = "%d fewer lines" },
		-- 				{ find = "%d more lines" },
		-- 				{ find = "line less;" },
		-- 				{ find = "lines yanked" },
		-- 				{ find = "/" },
		-- 			},
		-- 		},
		-- 		opts = { skip = true },
		-- 	},
		-- },
	},
}

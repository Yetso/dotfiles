return {
	"akinsho/bufferline.nvim",
	event = "VeryLazy",
	keys = {
		{ "<leader>bd", function() Snacks.bufdelete() end },
		{ "<S-h>",      "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
		{ "<S-l>",      "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
		{ "<leader>1",  function() require("bufferline").go_to(1, true) end },
		{ "<leader>2",  function() require("bufferline").go_to(2, true) end },
		{ "<leader>3",  function() require("bufferline").go_to(3, true) end },
		{ "<leader>4",  function() require("bufferline").go_to(4, true) end },
		{ "<leader>5",  function() require("bufferline").go_to(5, true) end },
		{ "<leader>6",  function() require("bufferline").go_to(6, true) end },
		{ "<leader>7",  function() require("bufferline").go_to(7, true) end },
		{ "<leader>8",  function() require("bufferline").go_to(8, true) end },
		{ "<leader>9",  function() require("bufferline").go_to(9, true) end },
	},
	opts = {
		options = {
			numbers = "ordinal",
			-- stylua: ignore
			close_command = function(n) Snacks.bufdelete(n) end,
			-- stylua: ignore
			right_mouse_command = function(n) Snacks.bufdelete(n) end,
			diagnostics = "nvim_lsp",
			always_show_bufferline = true,
			offsets = {
				{
					filetype = "snacks_layout_box",
				},
			},
		},
	},
}


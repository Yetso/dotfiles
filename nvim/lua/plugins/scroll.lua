vim.pack.add({
	"https://github.com/Aasim-A/scrollEOF.nvim",
	"https://github.com/dstein64/nvim-scrollview",
})

require("scrollEOF").setup({
	insert_mode = true
})

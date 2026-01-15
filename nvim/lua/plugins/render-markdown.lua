vim.pack.add({
	"https://github.com/MeanderingProgrammer/render-markdown.nvim",
}, {load = function() end})

vim.api.nvim_create_autocmd("FileType", {
	pattern = {  "markdown", "norg", "rmd", "org", "codecompanion" },
	once = true,
	callback = function()
		vim.cmd.packadd("render-markdown.nvim")
		require("render-markdown").setup()
	end,
})

vim.pack.add({
	{
		src = "https://github.com/chomosuke/typst-preview.nvim",
		version = vim.version.range(">1.0.0"),
		load = function() end
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "typst" },
	once = true,
	callback = function()
		vim.cmd.packadd("typst-preview.nvim")
		require("typst-preview").setup()
	end,
})

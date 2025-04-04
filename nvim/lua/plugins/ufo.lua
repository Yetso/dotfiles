
return {
	'kevinhwang91/nvim-ufo',
	dependencies = { 'kevinhwang91/promise-async' },
	opts = {
		provider_selector = function(_, _, buftype)
			if buftype == "nofile" then
				return ''
			end
			return {'treesitter', 'indent'}
		end

	},
	event = {"BufReadPre"},
	init = function()
		vim.o.foldcolumn = '1'
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.opt.fillchars = {
			fold = ' ', foldopen='', foldsep=' ', foldclose='',
			horiz = '━', horizup = '┻', horizdown = '┳',
			vert = '┃', vertleft = '┫', vertright = '┣',
			verthoriz = '╋',
		}
	end
}



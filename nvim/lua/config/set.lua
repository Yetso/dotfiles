vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
vim.cmd([[aunmenu PopUp.How-to\ disable\ mouse]])
vim.cmd([[aunmenu PopUp.-2-]])

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Case-insensitive searching (if smartcase) UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
-- vim.opt.smartcase = true

-- Enable break indent
vim.opt.breakindent = true
vim.opt.wrap = false

-- Keep signcolumn on by default
-- vim.opt.signcolumn = 'yes'

vim.opt.iskeyword:append("-")

-- Split Windows
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.updatetime = 300
vim.opt.timeoutlen = 800
-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

vim.o.hlsearch = true
vim.o.cursorline = true
vim.opt.laststatus = 3
vim.opt.showcmd = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- vim.opt.textwidth = 100
vim.opt.formatoptions:remove("t")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = (os.getenv("HOME") or os.getenv("USERPROFILE")) .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.sidescrolloff = 12
vim.opt.scrolloff = 10

vim.opt.confirm = true

vim.opt.matchpairs:append("<:>")

vim.opt.shortmess:append("c")

vim.opt.guicursor = "n-v-c:block-Cursor,i-ci-ve-t:ver25-Cursor,r:hor20-Cursor"

-- print checkhealth with float window
vim.g.health = { style = "float" }

vim.opt.winborder = "rounded"

vim.diagnostic.config({
	-- virtual_lines = { current_line = true },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅜",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
	},
})

vim.o.foldlevel = 99
vim.opt.fillchars = {
	fold = " ",
	foldopen = "",
	foldsep = " ",
	foldclose = "",
	horiz = "━",
	horizup = "┻",
	horizdown = "┳",
	vert = "┃",
	vertleft = "┫",
	vertright = "┣",
	verthoriz = "╋",
}
vim.opt.foldopen:remove("hor")

vim.opt.foldtext = "v:lua.custom_foldtext()"

local function fold_virt_text(result, s, lnum, coloff)
	if not coloff then
		coloff = 0
	end
	local text = ""
	local hl
	for i = 1, #s do
		local char = s:sub(i, i)
		local hls = vim.treesitter.get_captures_at_pos(0, lnum, coloff + i - 1)
		local _hl = hls[#hls]
		if _hl then
			local new_hl = "@" .. _hl.capture
			if new_hl ~= hl then
				table.insert(result, { text, hl })
				text = ""
				hl = nil
			end
			text = text .. char
			hl = new_hl
		else
			text = text .. char
		end
	end
	table.insert(result, { text, hl })
end

function _G.custom_foldtext()
	local start = vim.fn.getline(vim.v.foldstart)
	local end_str = vim.fn.getline(vim.v.foldend)
	local end_ = vim.trim(end_str)
	local result = {}
	fold_virt_text(result, start, vim.v.foldstart - 1)
	table.insert(result, { "  󰇘  ", "Visual" })
	fold_virt_text(result, end_, vim.v.foldend - 1, #(end_str:match("^(%s+)") or ""))
	return result
end

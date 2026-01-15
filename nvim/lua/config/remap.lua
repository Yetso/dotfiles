vim.keymap.set({ "n", "v" }, "<space>", ",<Nop>", { noremap = true, silent = true })
-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ "n", "t" }, "<C-h>", "<Cmd>wincmd h<CR>", { desc = "Move focus to the left window" })
vim.keymap.set({ "n", "t" }, "<C-l>", "<Cmd>wincmd l<CR>", { desc = "Move focus to the right window" })
vim.keymap.set({ "n", "t" }, "<C-j>", "<Cmd>wincmd j<CR>", { desc = "Move focus to the lower window" })
vim.keymap.set({ "n", "t" }, "<C-k>", "<Cmd>wincmd k<CR>", { desc = "Move focus to the upper window" })

-- copy to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { silent = true })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { silent = true })

-- dont move the cursor after a yanking
vim.keymap.set("v", "y", "ygv<Esc>", { noremap = true, silent = true })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv", { desc = "Indent left and reselect" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and reselect" })

-- inverse the mapping jump command
vim.keymap.set("n", "'", "`", { noremap = true })
vim.keymap.set("n", "`", "'", { noremap = true })

-- M to delete a mark
vim.keymap.set("n", "M", function()
	return ":delmarks " .. vim.fn.getcharstr() .. "<CR>"
end, { expr = true, silent = true })

-- LSP mapping
vim.keymap.del("n", "grn")
vim.keymap.set("n", "gln", vim.lsp.buf.rename, { noremap = true, silent = true, desc = "Go to LSP reName" })

vim.keymap.del("n", "gra")
vim.keymap.set("n", "gla", vim.lsp.buf.code_action, { noremap = true, silent = true, desc = "Go to LSP Action" })

vim.keymap.del("n", "grr")
vim.keymap.set("n", "glr", function()
	require("snacks").picker.lsp_references({ focus = "list" })
end, { noremap = true, silent = true, desc = "Go to LSP references" })

vim.keymap.del("n", "gri")
vim.keymap.set(
	"n",
	"gli",
	vim.lsp.buf.implementation,
	{ noremap = true, silent = true, desc = "Go to LSP Implementation" }
)

vim.keymap.del("n", "grt")
vim.keymap.set(
	"n",
	"glt",
	vim.lsp.buf.type_definition,
	{ noremap = true, silent = true, desc = "Go to LSP Type definition" }
)

vim.keymap.set("n", "gld", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to LSP Definition" })
vim.keymap.set("n", "gqq", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format buffer" })
vim.keymap.set("n", "gle", function()
	vim.diagnostic.open_float(nil, { focusable = true })
end, { noremap = true, silent = true, desc = "Print LSP messages" })

-- Quickly source current file / execute Lua code
vim.keymap.set("n", "<leader>x", "<Cmd>:.lua<CR>", { desc = "Lua: execute current line" })
vim.keymap.set("v", "<leader>x", "<Cmd>:lua<CR>", { desc = "Lua: execute current selection" })

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

-- dont move the cursor after a yanking
vim.keymap.set("v", "y", "ygv<Esc>", { noremap = true, silent = true })


-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move selection up" })

-- vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostic Quickfix list' })

vim.keymap.set('n', 'gr', '<Nop>')

vim.keymap.set("n", "grd", vim.lsp.buf.definition, { noremap = true, silent = true, desc = "Go to LSP definition" })

vim.keymap.set("n", "grf", vim.lsp.buf.format, { noremap = true, silent = true, desc = "Format buffer" })

-- Fonction pour vérifier si la fenêtre actuelle est flottante
local function is_floating_window()
	local config = vim.api.nvim_win_get_config(0)
	return config.relative ~= ""
end

-- Autocommand pour appliquer le remap uniquement si ce n'est pas LazyGit (ou autre fenêtre flottante)
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		-- Exclure les fenêtres flottantes comme LazyGit
		if not is_floating_window() then
			vim.api.nvim_buf_set_keymap(
				0,
				"t",
				"<Esc>",
				[[<C-\><C-n>]],
				{ noremap = true, silent = true, desc = "quit insert mode inside terminal" }
			)
		end
	end,
})


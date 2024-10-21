-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ 'n', 't' }, '<C-h>', '<Cmd>wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<Cmd>wincmd l<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<Cmd>wincmd j<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<Cmd>wincmd k<CR>', { desc = 'Move focus to the upper window' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { silent = true })

vim.keymap.set('n', '<leader>d', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Fonction pour vérifier si la fenêtre actuelle est flottante
local function is_floating_window()
	local config = vim.api.nvim_win_get_config(0)
	return config.relative ~= ''
end

-- Autocommand pour appliquer le remap uniquement si ce n'est pas LazyGit (ou autre fenêtre flottante)
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		-- Exclure les fenêtres flottantes comme LazyGit
		if not is_floating_window() then
			vim.api.nvim_buf_set_keymap(0, 't', '<Esc>', [[<C-\><C-n>]],
				{ noremap = true, silent = true, desc = "quit insert mode inside terminal" })
		end
	end
})

-- vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], {desc = "quit insert mode inside terminal"})

-- add Update command to shorten vim.pack.update()
vim.api.nvim_create_user_command("Update", function()
	vim.pack.update()
end, {})

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Change vers le répertoire du premier fichier ouvert au démarrage
vim.api.nvim_create_autocmd("VimEnter", {
	pattern = "*",
	callback = function()
		if vim.fn.argc() < 1 then
			return
		end
		local first_arg = vim.fn.argv(0)

		-- Gérer le cas où argv retourne un array
		if type(first_arg) == "table" then
			first_arg = first_arg[1]
		end

		if type(first_arg) ~= "string" or first_arg == "" then
			return
		end
		-- Convertir en chemin absolu
		local abs_path = vim.fn.fnamemodify(first_arg, ":p")

		local target_dir
		if vim.fn.isdirectory(abs_path) == 1 then
			-- Si c'est un dossier, utiliser directement
			target_dir = abs_path
		else
			-- Si c'est un fichier, prendre son répertoire parent
			target_dir = vim.fn.fnamemodify(abs_path, ":h")
		end
		vim.api.nvim_set_current_dir(target_dir)
		vim.o.scrolloff = 10
	end,
})

-- Autocommand pour appliquer le remap uniquement si ce n'est pas LazyGit (ou autre fenêtre flottante)
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "*",
	callback = function()
		vim.wo.scrolloff = 0
		-- Exclure les fenêtres flottantes comme LazyGit
		local config = vim.api.nvim_win_get_config(0)
		if config.relative == "" then
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

vim.api.nvim_create_autocmd("QuitPre", {
	callback = function()
		local snacks_windows = {}
		local floating_windows = {}
		local windows = vim.api.nvim_list_wins()
		for _, w in ipairs(windows) do
			local filetype = vim.api.nvim_get_option_value("filetype", { buf = vim.api.nvim_win_get_buf(w) })
			if filetype:match("snacks_") ~= nil then
				table.insert(snacks_windows, w)
			elseif vim.api.nvim_win_get_config(w).relative ~= "" then
				table.insert(floating_windows, w)
			end
		end
		if 1 == #windows - #floating_windows - #snacks_windows then
			-- Should quit, so we close all Snacks windows.
			for _, w in ipairs(snacks_windows) do
				vim.api.nvim_win_close(w, true)
			end
		end
	end,
})

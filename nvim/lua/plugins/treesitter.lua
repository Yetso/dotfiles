vim.filetype.add({
	extension = {
		zsh = "bash",
	},
})
vim.filetype.add({
	pattern = {
		["hypr.*%.conf"] = "hyprlang",
	},
})

vim.pack.add({
	"https://github.com/nvim-treesitter/nvim-treesitter",
})

local ensure_installed = {
	"bash",
	"c",
	"c_sharp",
	"csv",
	"diff",
	"go",
	"hyprlang",
	"java",
	"json",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"nix",
	"nu",
	"python",
	"query",
	"regex",
	"toml",
	"typst",
	"vim",
	"vimdoc",
	"xml",
	"yaml",
}

require("nvim-treesitter").install(ensure_installed)
vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Handle nvim-treesitter updates",
	group = vim.api.nvim_create_augroup("nvim-treesitter-pack-changed-update-handler", { clear = true }),
	callback = function(event)
		local name, kind = event.data.spec.name, event.data.kind
		if name == "nvim-treesitter" and (kind == "install" or kind == "update") then
			vim.notify("nvim-treesitter updated, running TSUpdate...", vim.log.levels.INFO)
			---@diagnostic disable-next-line: param-type-mismatch
			local ok = pcall(vim.cmd, "TSUpdate")
			if ok then
				vim.notify("TSUpdate completed successfully!", vim.log.levels.INFO)
			else
				vim.notify("TSUpdate command not available yet, skipping", vim.log.levels.WARN)
			end
		end
	end,
})


vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function(event)
		local bufnr = event.buf
		local filetype = vim.bo[bufnr].filetype

		-- Skip if no filetype
		if filetype == "" then
			return
		end

		-- Check if this filetype is already handled by explicit ensure_installed config
		for _, filetypes in pairs(ensure_installed) do
			local ft_table = type(filetypes) == "table" and filetypes or { filetypes }
			if vim.tbl_contains(ft_table, filetype) then
				return -- Already handled above
			end
		end

		-- Get parser name based on filetype
		local parser_name = vim.treesitter.language.get_lang(filetype) -- might return filetype (not helpful)
		if not parser_name then
			return
		end
		-- Try to get existing parser (helpful check if filetype was returned above)
		local parser_configs = require("nvim-treesitter.parsers")
		if not parser_configs[parser_name] then
			return -- Parser not available, skip silently
		end

		local parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

		if not parser_installed then
			-- If not installed, install parser synchronously
			require("nvim-treesitter").install({ parser_name }):wait(30000)
		end

		-- let's check again
		parser_installed = pcall(vim.treesitter.get_parser, bufnr, parser_name)

		if parser_installed then
			-- Start treesitter for this buffer
			vim.treesitter.start(bufnr, parser_name)
		end
	end,
})

vim.o.foldlevel = 99
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldmethod = "expr"

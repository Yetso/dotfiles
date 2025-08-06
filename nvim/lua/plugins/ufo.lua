local handler = function(virtText, lnum, endLnum, width, truncate)
	local newVirtText = {}
	local suffix = (" 󰁂 %d "):format(endLnum - lnum)
	local sufWidth = vim.fn.strdisplaywidth(suffix)
	local targetWidth = width - sufWidth
	local curWidth = 0
	for _, chunk in ipairs(virtText) do
		local chunkText = chunk[1]
		local chunkWidth = vim.fn.strdisplaywidth(chunkText)
		if targetWidth > curWidth + chunkWidth then
			table.insert(newVirtText, chunk)
		else
			chunkText = truncate(chunkText, targetWidth - curWidth)
			local hlGroup = chunk[2]
			table.insert(newVirtText, { chunkText, hlGroup })
			chunkWidth = vim.fn.strdisplaywidth(chunkText)
			-- str width returned from truncate() may less than 2nd argument, need padding
			if curWidth + chunkWidth < targetWidth then
				suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
			end
			break
		end
		curWidth = curWidth + chunkWidth
	end
	table.insert(newVirtText, { suffix, "MoreMsg" })
	return newVirtText
end

---@param bufnr number
local function customizeSelector(bufnr)
	local function handleFallbackException(err, providerName)
		if type(err) == "string" and err:match("UfoFallbackException") then
			return require("ufo").getFolds(bufnr, providerName)
		else
			return require("promise").reject(err)
		end
	end

	return require("ufo")
		.getFolds(bufnr, "lsp")
		:catch(function(err)
			return handleFallbackException(err, "treesitter")
		end)
		:catch(function(err)
			return handleFallbackException(err, "indent")
		end)
end

return {
	"kevinhwang91/nvim-ufo",
	dependencies = { "kevinhwang91/promise-async" },
	opts = {
		fold_virt_text_handler = handler,
		provider_selector = function(_, _, _)
			return customizeSelector
		end,
		-- 	function(bufnr, _, buftype)
		-- 	if buftype == "nofile" then
		-- 		return ''
		-- 	end
		-- 	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
		-- 	if #clients == 0 then
		-- 		return { 'treesitter', 'indent' }
		-- 	else
		-- 		return { 'lsp', 'treesitter' }
		-- 	end
		-- 	return { 'lsp', 'treesitter' }
		-- end
	},
	event = { "BufRead" },
	init = function()
		vim.o.foldcolumn = "0"
		vim.o.signcolumn = "yes"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.opt.foldopen:remove("hor")
		vim.opt.fillchars = {
			fold = " ",
			foldopen = "",
			foldsep = " ",
			foldclose = "",
		}
	end,
}

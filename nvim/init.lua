local ok, err = pcall(require, "config.set")
if not ok then
	vim.notify("Error loading configs".. err, vim.log.levels.ERROR)
end
local ok, err = pcall(require, "config.remap")
if not ok then
	vim.notify("Error loading remaps" .. err, vim.log.levels.ERROR)
end
local ok, err = pcall(require, "config.autocmds")
if not ok then
	vim.notify("Error loading autocmds" .. err, vim.log.levels.ERROR)
end

local plugins = vim.api.nvim_get_runtime_file("lua/plugins/*.lua", true)

for _, file in ipairs(plugins) do
	local module = file:match("lua/(.+)%.lua$"):gsub("/", ".")

	local ok, err = pcall(require, module)
	if not ok then
		vim.notify("Error loading plugin module " .. module .. ": " .. err, vim.log.levels.ERROR)
	end
end

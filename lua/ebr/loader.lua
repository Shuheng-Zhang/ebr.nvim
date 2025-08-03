--
-- ePub file loader
--
-- Loader helper for loading data from ePub file.
--
-- This loader can load infomations bellow from an ePub file:
--
-- ebook title
-- authors list
-- ebook description
-- chapters list, with chapter file herf
--

local M = {}

local zip = require("zip")
local xml2lua = require("xml2lua")
local xmlHandler = require("xml2lua.tree")

function M:open_file(filepath)
	local zfile, err = zip.open(filepath)
	if zfile then
		self.zfile = zfile
	else
		vim.notify("Failed to load file: " .. filepath .. ", error: " .. err, vim.log.levels.ERROR)
	end
end

function M:list_files()
	local list = {}
	for file in self.zfile:files() do
		table.insert(list, file.filename)
	end
	return list
end

function M:close_file()
	if self.zfile then
		self.zfile:close()
	end
end

return M

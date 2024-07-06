local M = {}
local lfs = require 'lfs'

M.new = function (path , basedir)
    if type(path) == 'string' then
        local link = path
        if basedir then
            link = system.pathForFile(path , basedir)
        end
        if link then
            local succes = lfs.mkdir(link)
        end
    end
end

local remove
local remove = function (path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local filePath = path.."/"..file
            local attr = lfs.attributes(filePath)
            if attr.mode == "directory" then
                remove(filePath)
            else
                os.remove(filePath)
            end
        end
    end
    lfs.rmdir(path)
end

M.remove = function (path , basedir)
    if type(path) == 'string' then
        local link = path
        if basedir then
            link = system.pathForFile(path , basedir)
        end
        if link then
            remove(link)
        end
    end
end

M.isFolder = function(path , basedir)
    if type(path) == 'string' then
        local link = path
        if basedir then
            link = system.pathForFile(path , basedir)
        end
        if link then
            local succes = lfs.chdir( link )
            return succes
        end
    end
end

return M
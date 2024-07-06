local M = {}

M.write = function (value , path , basedir)
    if type(path) ~= 'string' or value == nil then
        return true
    end
    local link = path
    if basedir then
        link = system.pathForFile(path , basedir)
    end
    local file = io.open(link , 'w')
    file:write(value)
    file:close()
end

M.read = function (path , mode , basedir)
    local link = path
    if type(path) ~= 'string' then
        return true
    end
    if type(mode) ~= 'string' then
        mode = '*a'
    end
    if basedir then
        link = system.pathForFile(path , basedir)
    end
    local file = io.open(link , 'r+')
    local value = file:read(mode)
    file:close()
    return value
end

M.remove = function (path , basedir)
    if type(path) ~= 'string' or value == nil then
        return true
    end
    local link = path
    if basedir then
        link = system.pathForFile(path , basedir)
    end
    os.remove(link)
end

return M
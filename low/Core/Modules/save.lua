local M = {}
M._saves = {}
local path = system.pathForFile('' , system.DocumentsDirectory)
local save = io.open(path .. '/' .. 'saves.txt' , 'r+')
if not save then
    local save2 = io.open(path .. '/' .. 'saves.txt' , 'w')
    save2:close()
    save = io.open(path .. '/' .. 'saves.txt' , 'r+')
end
local table = save:read('*a')
local json = require 'json'

if table == nil or table == '' then
    save:write('{}')
    save:close()
else
    save:close()
end
save = nil
local save = io.open(path .. '/' .. 'saves.txt' , 'r+')
local table = save:read('*a')
M._saves = json.decode(table)
save:close()
save = nil

M.save = function (key , value)
    if type(key) == 'string' then
        if value then
            M._saves[key] = value
            local save = io.open(path .. '/' .. 'saves.txt', 'r+')
            save:write(json.encode(M._saves))
            save:close()
            save = nil
        end
    end
end

M.load = function (key , defolt)
    if type(key) == 'string' then
        local value = M._saves[key] or (defolt or 0)

        return value
    else
        return defolt or 0
    end
end

return M
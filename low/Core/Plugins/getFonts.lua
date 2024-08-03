local M = {}
pcall(function ()
local res_path = '/data/data/' .. tostring(system.getInfo('androidAppPackageName')) .. '/files/coronaResources'
if low.device._window then
    res_path = system.pathForFile('',system.ResourcesDirectory)
end
local utf8 = require 'plugin.utf8'
local doc_dir = system.pathForFile('', system.DocumentsDirectory)
M._fonts = {}
local lfs = require 'lfs'
local path = 'FONTS'
low.folder.new('FONTS',system.DocumentsDirectory)


M.getFont = function(font)
    for i = 1, #M._fonts do
        if M._fonts[i][1] == font then
            local new_font = io.open(doc_dir .. '/' .. path .. '/' .. M._fonts[i][2], 'rb')
            local main_font = io.open(res_path .. '/' .. path .. '_' .. M._fonts[i][2], 'wb')

            if new_font and main_font then
                main_font:write(new_font:read('*a'))
                io.close(main_font)
                io.close(new_font)
            end

            return path .. '_' .. M._fonts[i][2]
        elseif M._fonts[i][1] == 'Documents:' .. font or M._fonts[i][1] == 'Temps:' .. font then
            local rfilename = utf8.reverse(M._fonts[i][2])
            local filename = utf8.reverse(utf8.sub(rfilename, 1, utf8.find(rfilename, '%/') - 1))
            local new_font = io.open(M._fonts[i][2], 'rb')
            local main_font = io.open(res_path .. '/' .. path .. '_' .. filename, 'wb')

            if new_font and main_font then
                main_font:write(new_font:read('*a'))
                io.close(main_font)
                io.close(new_font)
            end

            return path .. '_' .. filename
        end
    end

    return font
end

M.removeFont = function (name)
    pcall(function ()
    for i = 1, #M._fonts, 1 do
        if M._fonts[i][1] == name then
            os.remove(doc_dir .. '/' .. path .. '/' .. name)
            pcall(function ()
                os.remove(system.pathForFile(path .. '/' .. name, system.DocumentsDirectory))
            end)
            low.loop.new(20 , function ()
                os.exit()
            end)
        end
    end
            
end)
end

M.removeResources = function(directory)
    directory = M._res_path
    pcall(function ()
    for file in lfs.dir(directory) do
        if file:match("^FONTS_") then
            local filePath = directory .. "/" .. file
            os.remove(filePath)
        end
    end
    end)
end
M._res_path = res_path
M.removeResources()

--[[
M.removeFont = function (name)
    local index = #M._fonts
    for i = 1, index, 1 do
        if M._fonts[i][1] == name then
            low.file.remove(doc_dir .. '/M._fonts/' .. name)
            low.file.remove(res_path .. '/' .. path .. '_' .. name)
            table.remove(M._fonts , i)
            break
        end
    end
end]]

M.clearAll = function()
    M.removeResources(M._res_path)
    M._fonts = {}
end

M.newFont = function (name , path)
    local index = #M._fonts + 1
    M._fonts[index] = {name , name}
    if type(path) == 'string' then
        low.os.copy(path , doc_dir .. '/FONTS/' .. name)
    end
end
end)

return M
--[[
MIT License

Copyright (c) 2023 Leonid-Ganin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]
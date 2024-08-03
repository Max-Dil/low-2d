local M = {}
pcall(function ()
local utf = require 'plugin.utf8'

M.remove = function(link, recur)
    if low.device._window then
        link = utf.gsub(link, '/', '\\')
        if recur then os.execute('rd /s /q "' .. link .. '"')
        else os.execute('del /q "' .. link .. '"') end
    else
        os.execute('rm -' .. (recur and 'rf' or 'f') .. ' "' .. link .. '"')
    end
end

M.copy = function(link, link2)
    if low.device._window then
        link = utf.gsub(link, '/', '\\')
        link2 = utf.gsub(link2, '/', '\\')
        os.execute('copy /y "' .. link .. '" "' .. link2 .. '"')
    else
        os.execute('cp -f "' .. link .. '" "' .. link2 .. '"')
    end
end

M.move = function(link, link2)
    if low.device._window then
        link = utf.gsub(link, '/', '\\')
        link2 = utf.gsub(link2, '/', '\\')
        os.execute('move /y "' .. link .. '" "' .. link2 .. '"')
    else
        os.execute('mv -f "' .. link .. '" "' .. link2 .. '"')
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
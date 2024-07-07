--[[
MIT License

Copyright (c) 2024 Max-Dil

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

local M = {}
M.camers = {}

M.start = function (name)
    low.loop.resume(M.camers[name].timer)
end

M.stop = function (name)
    low.loop.pause(M.camers[name].timer)
end

M.create = function (name , smooth , object )
    if smooth == nil then
        smooth = 15
    end
    if object == nil or name == nil then
        return true
    end

    M.camers[name] = {}
    M.camers[name].smooth = smooth
    M.camers[name].group = display.newGroup()
    M.camers[name].focus = object
    M.camers[name].group:insert(M.camers[name].focus)
    M.camers[name].timer = low.loop.new(0 , function ()
        M.camers[name].group.x = (M.camers[name].group.x + ((-M.camers[name].focus.x + display.contentCenterX)-M.camers[name].group.x)/M.camers[name].smooth)
        M.camers[name].group.y = (M.camers[name].group.y + ((-M.camers[name].focus.y + display.contentCenterY)-M.camers[name].group.y)/M.camers[name].smooth)
    end, 0)
    low.loop.pause(M.camers[name].timer)
end

M.removeCamera = function (name)
    low.loop.remove(M.camers[name].timer)
    M.camers[name].group:removeSelf()
    M.camers[name] = nil
end

M.set_focus = function (name , object)
    M.remove(M.camers[name].focus)
    M.camers[name].focus = object
    M.camers[name].group:insert(M.camers[name].focus)
end

M.insert = function (name , object)
    M.camers[name].group:insert(object)
end

local json = require 'json'
M.remove = function(name , object)
    local ob = json.encode(object)
    object:removeSelf()
    object = json.decode(ob)
end

M.setSmooth = function (name , smooth)
    M.camers[name].smooth = smooth
end

M.clear = function ()
    for key, value in pairs(M.camers) do
        pcall(function()
            M.camers[key].group:removeSelf()
            M.camers[key].group = nil
            loop.loop.remove(M.camers[key].timer)
        end)
        M.camers = {}
    end
end

return M
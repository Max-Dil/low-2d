local M = {}
local plugin = require 'low.Core.Plugins.camera'

M.create = function (name , smooth , object)
    if type(name) == 'string' then
        if type(smooth) == 'number' then
            if object then
                plugin.create(name , smooth or 15 , object)
                low._SCENES[low._SCENES['_select']].group:insert(plugin.camers[name].group)
            end
        end
    end
end

M.start = function (name)
    if type(name) == 'string' then
        plugin.start(name)
    end
end

M.stop = function (name)
    if type(name) == 'string' then
        plugin.stop(name)
    end
end

M.removeCamera = function (name)
    if type(name) == 'string' then
        plugin.removeCamera(name)
    end
end

M.focus = function (name , object)
    if type(name)  == 'string' then
        if object then
            plugin.set_focus(name , object)
        end
    end
end

M.insert = function (name , object)
    if type(name) == 'string' then
        if object then
            plugin.insert(name , object)
        end
    end
end

M.remove = function (name , object)
    if type(name) == 'string' then
        if object then
            plugin.remove(name , object)
        end
    end
end

M.smooth = function (name , smooth)
    if type(name) == 'string' and type(smooth) == 'number' then
        plugin.setSmooth(name , smooth)
    end
end

M.clear = function ()
    plugin.clear()
end

return M
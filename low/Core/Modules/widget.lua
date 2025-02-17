local M = {}
local wid = require 'widget'

M.scroll = function (group , options)
    if low.graphics.isGroup(group) == false then
        group , options = low._SCENES[low._SCENES['_select']].group , group or nil
    else
        group , options = group or low._SCENES[low._SCENES['_select']].group , options or nil
    end
    if options ~= nil then
        local object = wid.newScrollView( options )
        group:insert(object)
        object.low = {}
        object.low.type = 'scroll'
        return object
    end
end

M.button = function (group , options)
    if low.graphics.isGroup(group) == false then
        group , options = low._SCENES[low._SCENES['_select']].group , group or nil
    else
        group , options = group or low._SCENES[low._SCENES['_select']].group , options or nil
    end
    if options ~= nil then
        local object = wid.newButton( options )
        group:insert(object)
        object.low = {}
        object.low.type = 'button'
        return object
    end
end

M.slider = function (group , options)
    if low.graphics.isGroup(group) == false then
        group , options = low._SCENES[low._SCENES['_select']].group , group or nil
    else
        group , options = group or low._SCENES[low._SCENES['_select']].group , options or nil
    end
    if options ~= nil then
        local object = wid.newSlider( options )
        group:insert(object)
        object.low = {}
        object.low.type = 'slider'
        return object
    end
end

M.switch = function (group , options)
    if low.graphics.isGroup(group) == false then
        group , options = low._SCENES[low._SCENES['_select']].group , group or nil
    else
        group , options = group or low._SCENES[low._SCENES['_select']].group , options or nil
    end
    if options ~= nil then
        local object = wid.newSwitch( options )
        group:insert(object)
        object.low = {}
        object.low.type = 'switch'
        return object
    end
end

return M
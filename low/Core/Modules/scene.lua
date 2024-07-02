local M = {}

M.load = function (name ,listener)
    local old = low._SCENES['_select']
    M.go(name)
    listener()
    M.go(old)
end

M.listener = function (name , listener)
    if name then
        low._SCENES[name].listener = listener
    end
end

M.new = function (name , listener)
    if name then
    name = name or 'main'
    low._SCENES[name] = {}
    low._SCENES[name].group = display.newGroup()
    low._SCENES[name].data = {events = {} , timers = {}}
    low._SCENES[name].listener = function ()
        
    end
    if listener ~= nil then
        M.listener(name , listener)
    end
    end
end

M.hide = function (name)
    name = name or low._SCENES['_select']
    low.event.clear.scene(low._SCENES['_select'])
    low.loop.pauseScene(name)
    if low._SCENES[name] ~= nil then
        low._SCENES[name].group.isVisible = false
    end
    if low._SCENES[name] then
        low._SCENES[name].listener({name = 'hide', error = low._SCENES[name].group.isVisible == false , scene = name})
    end
end

M.show = function (name)
    name = name or low._SCENES['_select']
    low.event.addIsScene(name)
    low.loop.resumeScene(name)
    if low._SCENES[name] ~= nil then
        low._SCENES[name].group.isVisible = true
    end
    if low._SCENES[name] then
        low._SCENES[name].listener({name = 'snow', error = low._SCENES[name].group.isVisible == true , scene = name})
    end
end

M.go = function (name)
    if name then
        if low._SCENES[name] == nil then
            M.new(name)
        end
    M.hide(low._SCENES['_select'])
    low._SCENES['_select'] = name
    M.show(name)
    low._SCENES[name].listener({name = 'scene', error = low._SCENES['_select'] == name , scene = name})
    end
end

M.remove = function (name)
    name = name or low._SCENES['_select']
    if name then
        pcall(function ()
            low.event.clear.scene(name , true)
            low.loop.removeScene(name)
            low._SCENES[name].group:removeSelf()
        end)
        if name == low._SCENES['_select'] then
            M.go('main')
        end
        low._SCENES[name].listener({name = 'remove', error = low._SCENES[name] == nil , scene = name})
        low._SCENES[name] = nil
    end
end

M.getScene = function () return low._SCENES['_select'] end

return M
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
    low._SCENES[name].data = {events = {} , timers = {} , vars = {}}
    low._SCENES[name].listener = function ()
    
    low.scene.area.insert(low.scene.area._area._select , name)
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
        low._SCENES[name].listener({name = 'show', error = low._SCENES[name].group.isVisible == true , scene = name})
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

M.var = function (name , value)
    if type(name) == 'string' and value then
        low._SCENES[low._SCENES['_select']].data.vars[name] = value
    end
end

M.getVar = function (name , defolt)
    if type(name) == 'string' then
        return low._SCENES[low._SCENES['_select']].data.vars[name] or (defolt or 0)
    else
        return defolt or 0
    end
end

M.getVarScene = function (scene , name , defolt)
    if type(name) == 'string' and type(scene) == 'string' then
        return low._SCENES[scene].data.vars[name] or (defolt or 0)
    else
        return defolt or 0
    end
end

M.insert = function (object , scene)
    if object then
        if scene then
            low._SCENES[scene].group:insert(object)
        else
            low._SCENES[low._SCENES['_select']].group:insert(object)
        end
    end
end

M.area = {
    _area = {},
    new = function (name)
        if name then
            M.area._area[name] = {
                scenes = {},
                data = {}
            }
        end
    end,
    go = function (name , oneScene)
        if name then
            if M.area._area[name] == nil then
                M.area.new(name)
            end
            M.area._area[M.area._area._select].data = low._SCENES
            for key, value in pairs(low._SCENES) do
                if key ~= '_select' then
                    low.scene.hide(key)
                end
            end
            low._SCENES = M.area._area[name].data
            M.area._area._select = name
            if M.area._area[name].data['main'] == nil then
                low.scene.new('main')
                low._SCENES['_select'] = 'main'
            end

            if oneScene then
                low.scene.show(oneScene)
            else
                low.scene.show(low._SCENES['_select'])
            end
        end
    end,
    remove = function (name)
        if name then
            for key, value in pairs(M.area._area[name].scenes) do
                low.scene.remove(key)
            end
            M.area._area[name] = nil
        end
    end,
    removeAll = function ()
        for name, val in pairs(M.area._area) do
            for key, value in pairs(M.area._area[name].scenes) do
                low.scene.remove(key)
            end
            M.area._area[name] = nil
        end
    end,
    insert = function (name , scene)
        M.area._area[M.area._area._select].scenes[scene] = nil
        M.area._area[name].scenes[scene] = low._SCENES[scene]
    end,
    load = function (name , listener)
        local old = M.area._area._select
        M.area.go(name)
        listener()
        M.area.go(old)
    end
}

return M
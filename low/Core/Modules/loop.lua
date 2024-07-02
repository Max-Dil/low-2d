local M = {}
local numTimers = 0

M.new = function (name , time , listener , iterator)
    pcall(function ()
    if type(name) == 'string' then
        if low._SCENES[low._SCENES['_select']].data.timers[name] ~= nil then
            timer.cancel(low._SCENES[low._SCENES['_select']].data.timers[name].timer)
        end
        low._SCENES[low._SCENES['_select']].data.timers[name] = {
            timer = timer.performWithDelay(time or 1000 , listener , iterator or 1),
            time = time or 1000,
            iterator = iterator
        }
        return low._SCENES[low._SCENES['_select']].data.timers[name].timer
    elseif type(name) == 'number' then
        numTimers = numTimers + 1
        if low._SCENES[low._SCENES['_select']].data.timers['timer' .. numTimers] ~= nil then
            timer.cancel(low._SCENES[low._SCENES['_select']].data.timers[name].timer)
        end
        low._SCENES[low._SCENES['_select']].data.timers['timer' .. numTimers] = {
            timer = timer.performWithDelay(name or 1000 , time , listener or 1),
            time = name or 1000,
            iterator = listener
        }
        return low._SCENES[low._SCENES['_select']].data.timers['timer' .. numTimers].timer
    end
end)
end

M.remove = function (obj)
    if obj then
        pcall(function ()
            if type(obj) == 'string' then
                timer.cancel(low._SCENES[low._SCENES['_select']].data.timers[obj].timer)
                low._SCENES[low._SCENES['_select']].data.timers[obj] = nil
            else
                timer.cancel(obj)
            end
        end)
    end
end

M.pause = function (obj)
    if obj then
        pcall(function()
            if type(obj) == 'string' then
                timer.pause(low._SCENES[low._SCENES['_select']].data.timers[obj].timer)
            else
                timer.pause(obj)
            end
        end)
    end
end

M.resume = function (obj)
    if obj then
        pcall(function ()
            if type(obj) == 'string' then
                timer.resume(low._SCENES[low._SCENES['_select']].data.timers[obj].timer)
            else
                timer.resume(obj)
            end
        end)
    end
end

M.removeScene = function (scene_name)
    scene_name = scene_name or low._SCENES['_select']
    for key, value in pairs(low._SCENES[scene_name].data.timers) do
        pcall(function ()
            timer.cancel(low._SCENES[scene_name].data.timers[key].timer)
            low._SCENES[scene_name].data.timers[key] = nil
        end)
    end
end

M.pauseScene = function (scene_name)
    scene_name = scene_name or low._SCENES['_select']
    for key, value in pairs(low._SCENES[scene_name].data.timers) do
        pcall(function ()
            timer.pause(low._SCENES[scene_name].data.timers[key].timer)
        end)
    end
end

M.resumeScene = function (scene_name)
    scene_name = scene_name or low._SCENES['_select']
    for key, value in pairs(low._SCENES[scene_name].data.timers) do
        pcall(function ()
            timer.resume(low._SCENES[scene_name].data.timers[key].timer)
        end)
    end
end

M.removeAll = function ()
    timer.cancelAll()
end

M.pauseAll = function ()
    timer.pauseAll()
end

M.resumeAll = function ()
    timer.resumeAll()
end

return M
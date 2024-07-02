local M = {}

M.new = function (obj , event , listener)
    local num = #low._SCENES[low._SCENES['_select']].data.events + 1
    low._SCENES[low._SCENES['_select']].data.events[num] = {
        obj = obj,
        event = event,
        listener = listener
    }
    obj:addEventListener(event ,listener )
end

M.remove = function (obj ,event , listener)
    local num = #low._SCENES[low._SCENES['_select']].data.events
    for i = 1,num , 1 do
        if low._SCENES[low._SCENES['_select']].data.events[i].obj == obj and
        low._SCENES[low._SCENES['_select']].data.events[i].event == event
        and low._SCENES[low._SCENES['_select']].data.events[i].listener == listener then
            table.remove(low._SCENES[low._SCENES['_select']].data.events , i)
        end
    end
    obj:removeEventListener(event ,listener )
end

M.clear = {
    scene = function (name , remove)
        local num = #low._SCENES[name].data.events
        for i = 1, num , 1 do
            pcall(function ()
            low._SCENES[name].data.events[i].obj:removeEventListener(
                low._SCENES[name].data.events[i].event
             ,low._SCENES[name].data.events[i].listener )
            end)
        end
        if remove ~= nil then
            low._SCENES[name].data.events = {}
        end
    end
}

M.addIsScene = function (name)
    pcall(function ()
            local num = #low._SCENES[name].data.events
        for i = 1,num , 1 do
            pcall(function ()
            low._SCENES[name].data.events[i].obj:addEventListener(
                low._SCENES[name].data.events[i].event
             ,low._SCENES[name].data.events[i].listener )
            end)
        end
        
    end)

end

return M
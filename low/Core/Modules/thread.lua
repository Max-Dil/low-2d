local m = {}
local data = {}

Runtime:addEventListener('enterFrame', function ()
    for i = 1, #data, 1 do
        if data[i][2] then
            coroutine.resume(data[i][1])
        end
    end
end)

m.status = function (p)
    for i = 1, #data, 1 do
        if data[i][1] == p then
            return data[i][2]
        end
    end
end

m.yield = function (p)
    for i = 1, #data, 1 do
        if data[i][1] == p then
            data[i][2] = false
            break
        end
    end
end

m.resume = function (p)
    for i = 1, #data, 1 do
        if data[i][1] == p then
            data[i][2] = true
            break
        end
    end
end

m.wait = function(time)
    local startTime = os.time()
    while os.time() - startTime < time do
        coroutine.yield()
    end
end

m.create = function (listener)
    local p = {coroutine.create(listener), true} -- p, isActive
    table.insert(data, p)
    return p[1]
end

m.remove = function (p)
    for i = 1, #data, 1 do
        if data[i][1] == p then
            table.remove(data, i)
            break
        end
    end
end

m.clear = function ()
    data = {}
end

return m
local M = {}

if low.device._window then
    local function mouseUpgate(ev)
        M.x = ev.x
        M.y = ev.y
        M.time = ev.time
        M.type = ev.type
        M.scrollX = ev.scrollX
        M.scrollY = ev.scrollY
    end
    Runtime:addEventListener('mouse' , mouseUpgate)
else
    M.x = 0
    M.y = 0
    M.time = 0
    M.type = 'null'
    M.scrollX = 0
    M.scrollY = 0
end

return M
local M = {}
local group = display.newGroup()
local notifications = {}
local num = 0

M.show = {
    up = function (text)
        if type(text) == 'string' or type(text) == 'number' then
        else
            print('Error (notifications.show.up)')
            return true
        end
        num = num + 1
        local num = num
        notifications['bg'..num] = display.newRoundedRect(low.device.centerX , low.device.maxY - 200 , low.device.width / 2 , 70 , 20)
        notifications['text'..num] = display.newText(text ,notifications['bg'..num].x , notifications['bg'..num].y , native.systemFont , 25 )
        notifications['text'..num]:setFillColor(0,0,0)
        low.loop.new(3000 , function ()
            pcall(function ()
                notifications['bg'..num]:removeSelf()
                notifications['text'..num]:removeSelf()
            end)
        end)
    end,
    error = function (text)
        error(text)
    end
}

M.hideAll = function ()
    pcall(function ()
        group:removeSelf()
        group = display.newGroup()
    end)
end

return M
-- main.lua
-- documantation https://low2d.nicepage.io

--[[
		['plugin.orientation'] = {publisherId = 'tech.scotth'},
		['plugin.utf8'] = {publisherId = 'com.coronalabs'},
        ['plugin.exportFile'] = {publisherId = 'com.solar2d'},
        ["plugin.tinyfiledialogs"] = { publisherId = "com.xibalbastudios",supportedPlatforms = { android = false } },
        ["plugin.androidFilePicker"] = {publisherId="tech.scotth",marketplaceId = "zag4fj"},
]] -- plugins in low

-- defolt scene - 'main'
require 'low.main'
require 'low.global'

local ob = {}
function low.main()
    local posx = save.load('posx' , 0)
    local posy = save.load('posy' , 0)
    ob['квадрат'] = graphics.rect('fill' , posx , posy , 100 , 100)
end

function low.update()
    if low.mouse.type == 'drag' then
        graphics.set.x(ob['квадрат'] , low.mouse.x)
        graphics.set.y(ob['квадрат'] , low.mouse.y)
        save.save('posx' , ob['квадрат'].x)
        save.save('posy' , ob['квадрат'].y)
    end
    --print(low.mouse.type)
end

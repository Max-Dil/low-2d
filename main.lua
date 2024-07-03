-- main.lua
-- documantation https://low2d.nicepage.io

-- defolt scene - 'main'
require 'low.main'
require 'low.global'

local ob = {}
function low.main()
    ob['квадрат'] = graphics.rect('fill' , 360 , 400 , 100 , 100)
    graphics.print('idi nax' , device.centerX , device.centerY)
end

function low.update()
    graphics.set.x(ob['квадрат'] , low.mouse.x)
    graphics.set.y(ob['квадрат'] , low.mouse.y)
end
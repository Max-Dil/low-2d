-- main.lua
-- documantation https://low2d.nicepage.io
require 'low.main'
require 'low.global'

local ob = {}
function low.main()
    ob['квадрат'] = graphics.rect('fill' , 360 , 400 , 100 , 100)
end

function low.update()
    graphics.set.x(ob['квадрат'] , low.mouse.x)
    graphics.set.y(ob['квадрат'] , low.mouse.y)
end
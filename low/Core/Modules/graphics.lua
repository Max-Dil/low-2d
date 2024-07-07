local M = {}

M.isGroup = function (obj)
    if type(obj) ~= "table" then
      return false
    end
  
    if obj.numChildren == nil then
      return false
    end

    if obj.insert == nil or obj.remove == nil then
      return false
    end
  
    return true
end

M.circle = function (group , render , x , y , radius)
    if M.isGroup(group) == false then
        group , render , x , y , radius = low._SCENES[low._SCENES['_select']].group , group or 'fill' , render or 0 , x or 0 , y or 50
    else
        group , render , x , y , radius = group , render or 'fill' , x or 0 , y or 0 , radius or 50
    end

    local obj = display.newCircle(group , x , y , radius)
    obj.setRender = M.setRender
    obj.setRgbColor = M.setRgbColor
    obj.setColor = M.setColor
    obj.event = {
        new = low.event.new,
        remove = low.event.remove
    }
    obj.low = {}
    obj.low.type = 'circle'
    if render ~= nil then
        M.set.render(obj , render)
    end
    return obj
end

M.rect = function (group , render , x , y , width , height , round)
    if M.isGroup(group) == false then
        group , render , x , y , width , height , round = low._SCENES[low._SCENES['_select']].group , group or 'fill' , render or 0 , x or 0 , y or 50 , width or 50 , height or 0
    else
        group , render , x , y , width , height , round = group , render or 'fill' , x or 0 , y or 0 , width or 50 , height or 50 , round or 0
    end
    
    local obj = display.newRoundedRect(group , x , y , width , height , round)
    obj.setRender = M.setRender
    obj.setRgbColor = M.setRgbColor
    obj.setColor = M.setColor
    obj.event = {
        new = low.event.new,
        remove = low.event.remove
    }
    obj.low = {}
    obj.low.type = 'rect'
    if render ~= nil then
        M.set.render(obj , render)
    end
    return obj
end

M.image = function (group , image , basedir , x , y)
    if M.isGroup(group) == false then
        if type(basedir) == 'string'  then
            group , image , basedir , x , y = low._SCENES[low._SCENES['_select']].group, group , image , basedir or 0 , x or 0
        else
            group , image , x , y = low._SCENES[low._SCENES['_select']].group, group , image or 0 , basedir or 0
        end
    else
        if type(basedir) == 'string' then
            group , image , basedir , x , y = group , image , basedir , x or 0 , y or 0
        else
            group , image , x , y = group , image , basedir or 0 , x or 0
        end
    end

    local object = ''
    if type(basedir) == 'string' then
        object = display.newImage(group , image , basedir , x , y)
    else
        object = display.newImage(group , image , x , y)
    end
    if object then
    object.setRgbColor = M.setRgbColor
    object.setColor = M.setColor
    object.event = {
        new = low.event.new,
        remove = low.event.remove
    }
    object.low = {}
    object.low.type = 'image'
    return object
    end
end

M.print = function (group , text , x , y, font , fontSize)
    if M.isGroup(group) == false then
        group , text , x , y , font , fontSize = low._SCENES[low._SCENES['_select']].group , group or 'no text' , text or 0 , x or 0 , y or native.systemFont , font or 20
    else
        group , text , x , y , font , fontSize = group or low._SCENES[low._SCENES['_select']].group , text or 'no text' , x or 0 , y or 0 , font or native.systemFont , fontSize or 20
    end
    local object = display.newText(group , text , x , y , font , fontSize)
    object.setRgbColor = M.setRgbColor
    object.setColor = M.setColor
    object.event = {
        new = low.event.new,
        remove = low.event.remove
    }
    object.low  = {}
    object.low.type = 'print'
    return object
end

M.text = function (group , text , x , y , width , height , font , fontSize)
    if M.isGroup(group) == false then
        group , text , x , y ,width , height , font , fontSize = low._SCENES[low._SCENES['_select']].group, group or 'no text' , text or 0 , x or 0 , y or nil , width or nil , height or native.systemFont, font or 25
    else
        group , text , x , y ,width , height , font , fontSize = group or low._SCENES[low._SCENES['_select']].group , text or 'no text' , x or 0 , y or 0 , width or nil , height or nil, font or native.systemFont , fontSize or 25
    end
    local object = display.newText(group , text , x , y , width , height , font , fontSize)
    object.setRgbColor = M.setRgbColor
    object.setColor = M.setColor
    object.event = {
        new = low.event.new,
        remove = low.event.remove
    }
    object.low  = {}
    object.low.type = 'text'
    return object
end

M.group = function ()
    local object = display.newGroup()
    low._SCENES[low._SCENES['_select']].group:insert(object)
    object.low = {}
    object.low.type = 'group'
    return object
end

M.set = {
    image = function (object , image , basedir)
        if basedir then
            object.fill = {type = 'image' , filename = image , basedir = basedir}
        else
            object.fill = {type = 'image' , filename = image}
        end
    end,
    color = function (obj , r , g , b , a )
        if obj then
        if obj.low.renderType == 'fill' then
            r , g , b , a = r or 1 , g or 1 , b or 1 , a or nil
            if a ~= nil then
                obj:setFillColor(r , g , b , a)
            else
                obj:setFillColor(r , g , b)
            end
        elseif obj.low.renderType == 'line' then
            r , g , b , a = r or 1 , g or 1 , b or 1 , a or nil
            if a ~= nil then
                obj:setStrokeColor(r , g , b , a)
            else
                obj:setStrokeColor(r , g , b)
            end
        elseif obj.low.renderType == 'strokeFill' then
            if type(r) == 'table' and type(g) == 'table' and type(b) == 'table' then
                if (a == nil or a == {}) then
                    a = {1 , 1}
                end
                r[1] , g[1] , b[1] = r[1] or 1 , g[1] or 1 , b[1] or 1
                r[2] , g[2] , b[2] = r[2] or 1 , g[2] or 1 , b[2] or 1
                obj:setStrokeColor(r[1] , g[1] , b[1] , a[1])
                obj:setFillColor(r[2] , g[2] , b[2] , a[2])
            end
        else
            r , g , b , a = r or 1 , g or 1 , b or 1 , a or nil
            if a ~= nil then
                obj:setFillColor(r , g , b , a)
            else
                obj:setFillColor(r , g , b)
            end
        end
        end
    end,

    render = function(obj , render , lineWidth)
        if obj then
        render = render or 'fill'
        lineWidth = lineWidth or 5
        obj.low = obj.low == nil and {} or obj.low
        obj.low.renderType = render
            if render == 'fill' then
                obj:setFillColor(1, 1, 1)
            elseif render == 'line' then
                obj:setFillColor(0, 0, 0, 0)
                obj:setStrokeColor(1, 1, 1, 1)
                obj.strokeWidth = lineWidth
            elseif render == 'strokeFill' then
                obj:setStrokeColor(1, 1, 1, 1)
                obj.strokeWidth = lineWidth
            end
        end
    end,

    rgbColor = function (obj , r , g , b , a )
        if obj then
        if obj.low.renderType == 'fill' then
            r , g , b , a = r or 255 , g or 255 , b or 255 , a or nil
            if a ~= nil then
                obj:setFillColor(r/255 , g/255 , b/255 , a)
            else
                obj:setFillColor(r/255 , g/255 , b/255)
            end
        elseif obj.low.renderType == 'line' then
            r , g , b , a = r or 255 , g or 255 , b or 255 , a or nil
            if a ~= nil then
                obj:setStrokeColor(r/255 , g/255 , b/255 , a)
            else
                obj:setStrokeColor(r/255 , g/255 , b/255)
            end
        elseif obj.low.renderType == 'strokeFill' then
            if type(r) == 'table' and type(g) == 'table' and type(b) == 'table' then
                if (a == nil or a == {}) then
                    a = {255 , 255}
                end
                r[1] , g[1] , b[1] = r[1] or 255 , g[1] or 255 , b[1] or 255
                r[2] , g[2] , b[2] = r[2] or 255 , g[2] or 255 , b[2] or 255
                obj:setStrokeColor(r[1]/255 , g[1]/255 , b[1]/255 , a[1]/255)
                obj:setFillColor(r[2]/255 , g[2]/255 , b[2]/255 , a[2]/255)
            end
        else
            r , g , b , a = r or 1 , g or 1 , b or 1 , a or nil
            if a ~= nil then
                obj:setFillColor(r , g , b , a)
            else
                print(999)
                obj:setFillColor(r , g , b)
            end
        end
        end
    end,

    width = function (object , width) if width then if type(width) == 'number' then object.width = width end end end,
    height = function (object , height) if height then if type(height) == 'number' then object.height = height end end end,
    size = function (object , width , height) if width and height then if type(width) == 'number' and type(height) == 'number' then object.width , object.height = width , height end end end,
    x = function (object , x) if x then if type(x) == 'number' then object.x = x end end end,
    y = function (object , y) if y then if type(y) == 'number' then object.y = y end end end,
}

M.setRender = M.set.render
M.setColor = M.set.color
M.setRgbColor = M.set.rgbColor
M.setWidth = M.set.width
M.setHeight = M.set.height
M.setSize = M.set.size
M.setX = M.set.x
M.setY = M.set.y
M.setImage = M.set.image

return M
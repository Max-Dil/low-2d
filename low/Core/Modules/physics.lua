local physics=require'physics'
local M={}
local OPTIONS = {
    gravityX = 0,
    gravityY = 6,
    on = false
}

physics.start()
physics.setGravity(0,6)

physics.setDrawMode('hybrid') -- beta
physics.stop()

M.on=function(sleep)physics.start(sleep)OPTIONS.on=true end
M.off=function()physics.stop()OPTIONS.on=false end

M.add=function(object,tip,options)
    if type(tip)=='table'then
        options=tip
        tip='static'
    end
    if object.low.physics then
        local table=object.low.physics
        table.body={
            on=true,
            friction=options.friction or 0,
            bounce=options.bounce or 0,
            density=options.density or 1,
            type=tip,
            radius=options.radius or nil
        }
        object.isSensor=false
        object.isBullet=false
        object.isSleepingAllowed=false
        object.isFixedRotation=false
        object.gravityScale=1
        table.friction=options.friction or 0
        table.bounce=options.bounce or 0
        table.density=options.density or 1
        physics.addBody(object,tip,options)
    else
        error('The object does not support physics')
    end
end


M.setVelocity=function(object,velocity)
    if type(velocity)=='number' then
        object.angularVelocity = velocity
    else
        error('Only numbers are supported')
    end
end
M.applyForce=function(object,xForce,yForce,bodyX,bodyY)
    object:applyForce( xForce, yForce, bodyX, bodyY )
end
M.applyRotation=function(object,force)
    if type(force)=='number' then
        object:applyTorque( force )
    else
        error('Only numbers are supported')
    end
end
M.setBodyType=function(object,tip)
    if type(tip)=='string' then
        object.low.physics.body.type=tip
        object.bodyType=tip
    end
end
M.getLinearVelocity=function(object)
    local vx,vy=object:getLinearVelocity()
    return vx,vy
end
M.setGravity=function(object,gravityxy)
    object.low.physics.body.gravity=gravityxy
    object.gravityScale=gravityxy/10
end
M.active=function(object,active)
    if type(active)=='boolean' then
        object.isBodyActive=active
    else
        error('only true or false is supported')
    end
end
M.fixedRotation=function(object,fixed)
    if type(fixed)=='boolean' then
        object.low.physics.body.fixedRotation=fixed
        object.isFixedRotation=fixed
    else
        error('only true or false is supported')
    end
end
M.bullet=function(object,bullet)
    if type(bullet)=='boolean' then
        object.low.physics.body.bullet=bullet
        object.isBullet=bullet
    else
        error('only true or false is supported')
    end
end
M.sensor=function(object,sensor)
    if type(sensor)=='boolean' then
        object.low.physics.body.sensor=sensor
        object.isSensor=sensor
    else
        error('only true or false is supported')
    end
end
M.disableSleep=function(object)
    object.low.physics.body.sleep=false
    object.isSleepingAllowed=false
end
M.allowSleep=function(object)
    object.low.physics.body.sleep=true
    object.isSleepingAllowed=true
end
M.setLinearDamping=function(object,damp)
    if type(damp)=='number' then
        object.linearDamping=damp
    else
        error('Only the number in the setLinearDamping parameter 2 is supported')
    end
end
M.setLinearVelocity=function(object,xVelocity,yVelocity)
    local vx,vy=object:getLinearVelocity()
    if xVelocity==true then
        xVelocity=vx
    end
    if yVelocity==true then
        yVelocity=vy
    end
    object:setLinearVelocity(xVelocity,yVelocity)
end

M.rayCast=function(fromX,fromY,toX,toY,behavior)
    return physics.rayCast(fromX,fromY,toX,toY,behavior)
end
M.reflectRay=function(fromX,fromY,hit)
    return physics.reflectRay(fromX,fromY,hit)
end

M.recover=function (object)
    local table=object.low.physics
    local body=table.body
    body.on=true
    physics.addBody(object,body.type,{
    friction=body.friction,
    bounce=body.bounce,
    density=body.density,
    radius=body.radius
})
    object.isSensor=body.sensor or false
    object.isBullet=body.bullet or false
    object.isSleepingAllowed=body.sleep or false
    object.gravityScale=body.gravity or 1
    object.isFixedRotation=body.fixedRotation or false
end

M.remove=function(object)
    if object.low.physics.body.on then
        object.low.physics.body.on=false
        physics.removeBody(object)
    end
end

M.showHitboxs=function()physics.setDrawMode('hybrid')end
M.hideHitboxs=function()physics.setDrawMode('normal')end

M.getGlobalGravity=function()return OPTIONS.gravityX,OPTIONS.gravityY end
M.setGlobalGravity=function(gx,gy)
    if type(gx)=='number'and type(gy)=='number' then
        OPTIONS.gravityX=gx
        OPTIONS.gravityY=gy
        physics.setGravity(gx,gy)
    else
        error('gravity x and gravity y in setGlobalGravity can only be a number')
    end
end

M.reboot=function()physics.stop()physics.start()end
M.offScene=function(scene)
    local objects=low.copyTable(low._SCENES[scene].data.objects)
    for index,value in ipairs(objects)do
        if value~=nil then
            if value.low.physics then
                if value.low.physics.body.on then
                    pcall(function()
                        physics.removeBody(low._SCENES[scene].data.objects[index])
                    end)
                end
            end
        end
    end
end
M.onScene=function(scene)
    local objects=low.copyTable(low._SCENES[scene].data.objects)
    for index,value in ipairs(objects)do
        if value~=nil then
            if value.low.physics then
                if value.low.physics.body.on then
                    pcall(function()
                        local obj=low._SCENES[scene].data.objects[index]
                      --  local body=obj.low.physics.body
                        M.recover(obj)
                    end)
                end
            end
        end
    end
end

return M
local M = {}

M._window = system.getInfo('platform') ~= 'android' or system.getInfo('environment') == 'simulator'
M._android = system.getInfo('platform') == 'android'

if M._window and M._android then
    M._android = false
end

M.forAndroid = false
M.checkAndroid = function ()
    local loadedOri = require 'plugin.orientation' or false
        if loadedOri then
        else
            print('\nThe orientation plugin for android was not found\
no plugin plugin.orientation\
add the plugin to build.settings:\
["plugin.orientation"] = { publisherId="tech.scotth", marketplaceId = "zag4fj"}\n')
        end
end

M.window = {
    width = display.contentWidth,
    height = display.contentHeight,
    setSize = function (width , height)
        if width and height then
            if type(width) == 'number' and type(height) == 'number' then
                if system.getInfo('environment') ~= 'simulator' then
                    M.window.width = width
                    M.window.height = height
                    native.setProperty('windowSize',{ width = width, height = height})
                    M.width = display.actualContentWidth
                    M.height = display.actualContentHeight
                else
                    print('\nNot supported in simulation (window.setSize)\n')
                end
            else
                print('\nNeed number (window.setSize)\n')
            end
        else
            print('\nError (window.setSize)\n')
        end
    end,
    orientation = {
    set = function (land)
        if land then
            if type(land) == 'string' then
                if system.getInfo('environment') ~= 'simulator' then
                    M.window.width , M.window.height = M.window.height , M.window.width
                    M.app.resize(land)
                    M.window.setSize(M.window.width , M.window.height)
                else
                    print('\nNot supported in simulation (window.orientation.set)\n')
                end
            else
                print('\nNeed string (window.orientation.set)\n')
            end
        else
            print('\nError (window.orientation.set)\n')
        end
    end},
    setProperty = function (mode)
        native.setProperty('windowMode' , mode)
    end,
    setText = function (text)
        native.setProperty( "windowTitleText", text )
    end
}

M.android = {
    orientation = {
        set = function (land)
            if land then
                if type(land) == 'string' then
                    if M._android then
                        print(M._android)
                        if M.android.orientation.plugin ~= 0 then
                            M.app.resize(land)
                            M.android.orientation.plugin.lock(land)
                        else
                            low.notification.show.error('Error loaded plugin orientation. (android.orientation.set)')
                        end
                    else
                        if M.forAndroid then
                            print('\nadd it to the apk to make it work plugin.orientation (android.orientation.set)\n')
                        else
                            print('\nplugin orientation it only works on android (android.orientation.set)\n')
                        end
                    end
                else
                    print('\nError, orientation in string (android.orientation.set)\n')
                end
            else
                print('\nError (android.orientation.set)\n')
            end
        end,
        plugin = 0
    },
}


if M._android == true then
    local loadedOri = require 'plugin.orientation' or false
    if loadedOri then
        M.android.orientation.plugin = loadedOri
        M.android.orientation.plugin.init()
    end
end

M.app = {
    resize = function (type)
        if M.orientation ~= type then
            M.centerX, M.centerY = M.centerY, M.centerX
            M.width, M.height = M.height, M.width
            M.topHeight, M.leftHeight = M.leftHeight, M.topHeight
            M.bottomHeight, M.rightHeight = M.rightHeight, M.bottomHeight
    
            M.zeroX = M.centerX - M.width / 2 + M.leftHeight
            M.zeroY = M.centerY - M.height / 2 + M.topHeight
            M.maxX = M.centerX + M.width / 2 - M.rightHeight
            M.maxY = M.centerY + M.height / 2 - M.bottomHeight
        end
    
        M.orientation = type
    end
}

M.orientation = 'portrait'
M.centerX = display.contentCenterX
M.centerY = display.contentCenterY
M.width = display.actualContentWidth
M.height = display.actualContentHeight
M.topHeight, M.leftHeight, M.bottomHeight, M.rightHeight = display.getSafeAreaInsets()
M.zeroX = M.centerX - M.width / 2 + M.leftHeight
M.zeroY = M.centerY - M.height / 2 + M.topHeight
M.maxX = M.centerX + M.width / 2 - M.rightHeight
M.maxY = M.centerY + M.height / 2 - M.bottomHeight

timer.performWithDelay(10 , function ()
    if M.forAndroid then
        M.checkAndroid()
    end
end)

return M
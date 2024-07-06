_G.low = {}
low.device = require 'low.Core.Modules.device'
low.graphics = require 'low.Core.Modules.graphics'
low.scene = require 'low.Core.Modules.scene'
low.event = require 'low.Core.Modules.event'
low.loop = require 'low.Core.Modules.loop'
low.notification = require 'low.Core.Modules.notification'
low.save = require 'low.Core.Modules.save'
low.file = require 'low.Core.Modules.file'
low.folder = require 'low.Core.Modules.folder'
low.widget = require 'low.Core.Modules.widget'

low.json = require 'low.Core.Plugins.json'
low.mouse = require 'low.Core.Modules.mouse'

low._SCENES = {}
low.scene.new('main')
low._SCENES['_select'] = 'main'

display.setStatusBar(display.HiddenStatusBar)
display.setStatusBar(display.TranslucentStatusBar)
display.setStatusBar(display.HiddenStatusBar)                            
timer.performWithDelay(system.getInfo 'environment' == 'simulator' and 1 or 100, function()
    display.setStatusBar(display.HiddenStatusBar)
    display.setStatusBar(display.TranslucentStatusBar)
    display.setStatusBar(display.HiddenStatusBar)

    if low.main then
        if type(low.main) == 'function' then
            low.main()
        else
            print('\nlow.main is not a function\n')
        end
    else
        print('\nthere is no low.main function\n')
    end

    if low.update then
        if type(low.update) == 'function' then
            Runtime:addEventListener('enterFrame' , low.update)
        else
            print('\nlow.update is not a function\n')
        end
    else
        print('\nthere is no low.update function\n')
    end
end)
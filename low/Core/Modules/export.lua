local exportFile = {}
pcall(function ()
--[[
		['plugin.exportFile'] = {publisherId = 'com.solar2d'},
        ["plugin.tinyfiledialogs"] = { publisherId = "com.xibalbastudios",supportedPlatforms = { android = false } },
        ["plugin.utf8"] = { publisherId = "com.coronalabs"},
]]
exportFile = require ('plugin.exportFile')

if low.device._window then
    FILEPICKER = require 'plugin.tinyfiledialogs'
    exportFile.export = function(config)
        pcall(function ()
        local path, listener, name = config.path, config.listener, config.name
        local pathToFile = FILEPICKER.saveFileDialog({})
        if path then low.os.copy(path, pathToFile) end listener()          
        end)
    end
end
end)
return exportFile
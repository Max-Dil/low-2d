local M = {}
pcall(function ()
M = require("plugin.androidFilePicker")

--[[
        ["plugin.tinyfiledialogs"] = { publisherId = "com.xibalbastudios",supportedPlatforms = { android = false } },
        ["plugin.utf8"] = { publisherId = "com.coronalabs"},
        ["plugin.androidFilePicker"] = {publisherId="tech.scotth",marketplaceId = "zag4fj"},
]]

if low.device._window then
    FILEPICKER = require 'plugin.tinyfiledialogs'


    M = {}
    M.show = function(mime ,path, listener)
        local filter_patterns = mime == 'image/*' and {'*.png', '*.jpg', '*.jpeg', '*.gif'}
        or mime == 'audio/*' and {'*.wav', '*.mp3', '*.ogg'} or mime == 'ccode/*' and {'*.ccode', '*.zip'}
        or mime == 'text/x-lua' and {'*.lua', '*.txt'} or mime == 'video/*' and {'*.mov', '*.mp4', '*.m4v', '*.3gp'} or nil
        local pathToFile , path = path , FILEPICKER.openFileDialog({filter_patterns = filter_patterns})
        if path then low.os.copy(path, pathToFile) end listener({isError = path and false or true, done = path and 'ok' or 'error', origFileName = path})
    end
end
    
end)
return M
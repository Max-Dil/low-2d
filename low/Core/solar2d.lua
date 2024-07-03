local M = {}

_G.display = _G.display

M.print = print
M.require = require
M.timer = timer
M.display = display
M.native = native
M.widgets = require 'widget'
M.audio = audio
M.composer = require 'composer'
M.crypto = require 'crypto'
M.pcall = pcall
M.select = select
M.type = type
M.tonumber = tonumber
M.tostring = tostring
M.setmetatable = setmetatable
M.unpack = unpack
M.loadstring = loadstring
M.io = io
M.os = os
M.math = math
M.network = network
M.physics = require 'physics'
M.string = string
M.system = system
M.table = table
M.json = require 'low.Core.Plugins.json'
M.socket = require 'socket'
M.audio = audio
M.low = {}
M.getmetatable = getmetatable
M.pairs = pairs

M.s2d = {
    display = _G.display,
    timer = _G.timer,
    system = _G.system,
    audio = _G.audio
}

return M
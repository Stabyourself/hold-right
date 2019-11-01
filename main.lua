love.graphics.setDefaultFilter("nearest")

require "run"
require "environment"
class = require "lib.middleclass"
inspect = function(v) print(require "lib.inspect"(v)) end -- good code

local FrameDebug3 = require "lib.FrameDebug3"
local postScaler = require "lib.postScaler"
local baton = require "lib.baton"
local gamestate = require "lib.gamestate"
local game = require "game"

function love.load()
    postScaler.init(320, 180, 4)
    controls = baton.new(require "controls")

    gamestate.registerEvents()
    gamestate.switch(game)
end

function love.update(dt)
    controls:update()
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    end

    if key == "#" then
        FrameDebug3.frameAdvance()
    end

    if key == "pause" then
        FrameDebug3.pausePlay()
    end
end

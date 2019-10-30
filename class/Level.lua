local Level = class("Level")

local bump = require "lib.bump"
local sti = require "lib.sti"
local gamera = require "lib.gamera"
local Player = require "class.Player"

function Level:initialize(path)
    self.world = bump.newWorld()
    self.map = sti(path, {"bump"})
    self.map:bump_init(self.world)
    
    self.camera = gamera.new(0, 0, 1000, 1000, 320, 180)

    self.player = Player:new(self.world, 24, 24)
end

function Level:update(dt)
    -- CAMERA
    local moveX, moveY = controls:get("camera")

    local camX, camY = self.camera:getPosition()
    camX = camX + moveX
    camY = camY + moveY

    self.camera:setPosition(camX, camY)

    local zoom = self.camera:getScale()
    if controls:get('camzoomin') == 1 then
        zoom = zoom*1.1
    end

    self.camera:setScale(zoom)

    -- PLAYER
    self.player:update(dt)
end

function Level:draw()
    local xOff = (self.camera.w2 + self.camera.l) - self.camera.x*self.camera.scale
    local yOff = (self.camera.h2 + self.camera.t) - self.camera.y*self.camera.scale

    self.camera:draw(function()
        self.map:draw(xOff, yOff, self.camera.scale, self.camera.scale)

        -- debug
        if true then
            love.graphics.setColor(1, 0, 0)
            love.graphics.push()
            love.graphics.translate(0.5, 0.5)
            
            for _, item in ipairs(self.world:getItems()) do
                love.graphics.rectangle("line", self.world:getRect(item))
            end

            love.graphics.pop()
            love.graphics.setColor(1, 1, 1)
        end

        love.graphics.print("HUP!")
    end)
end

return Level

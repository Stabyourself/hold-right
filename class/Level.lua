local Level = class("Level")

local bump = require "lib.bump"
local sti = require "lib.sti"
local camera = require "lib.camera"
local Player = require "class.Player"
local Bullet = require "class.Bullet"

function Level:initialize(path)
    self.world = bump.newWorld()
    self.world.level = self -- I never know if this is good code
    self.map = sti(path, {"bump"})
    self.map:bump_init(self.world)

    self.entities = {
        bullets = {},
        players = {},
    }

    local startX, startY

    -- load objects
    for _, object in ipairs(self.map.layers.markers.objects) do
        local type = object.properties.type

        if type == "start" then
            startX = object.x+(16-PLAYERWIDTH)*0.5
            startY = object.y-PLAYERHEIGHT
        end
    end

    table.insert(self.entities.players, Player:new(self, startX, startY))
    self.camera = camera()
    self.camera:lookAt(self.entities.players[1].x+self.entities.players[1].w/2, self.entities.players[1].y+self.entities.players[1].h/2)
    self.camera:zoomTo(4)
end

function Level:update(dt)
    -- PLAYER
    for _, group in pairs(self.entities) do
        for i = #group, 1, -1 do
            group[i]:update(dt)

            if group[i].delete then
                self.world:remove(group[i])
                table.remove(group, i)
            end
        end
    end

    -- camera
    self.camera:lockWindow(
        self.entities.players[1].x+self.entities.players[1].w/2,
        self.entities.players[1].y+self.entities.players[1].h/2,
        love.graphics.getWidth()*0.5 - 100,
        love.graphics.getWidth()*0.5 + 100,
        love.graphics.getHeight()*0.5 - 50,
        love.graphics.getHeight()*0.5 + 50,
        camera.smooth.damped(dt, 10)
    ) --todo: some kind of SMW camera thing maybe
end

function Level:draw()
    self.camera:attach()

    self.map:drawLayer(self.map.layers.world)

    for _, group in pairs(self.entities) do
        for _, entity in ipairs(group) do
            entity:draw()
        end
    end
    self.entities.players[1]:draw()

    -- debug
    if DEBUG then
        self.map:drawLayer(self.map.layers.markers)
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

    self.camera:detach()    
end

function Level:makeBullet(owner, x, y, vx, vy)
    table.insert(self.entities.bullets, Bullet:new(self, owner, x, y, vx, vy))
end

return Level

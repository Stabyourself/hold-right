local Entity = require "class.Entity"
local Hand = require "class.Hand"
local Peashooter = require "class.guns.Peashooter"

local Player = class("Player", Entity)

local img = love.graphics.newImage("img/player.png")

local runAccel = 200
local brakeAccel = 500
local maxSpeed = 100

local w, h = 12, 12

function Player:initialize(level, x, y)
    Entity.initialize(self, level, x, y, w, h)

    -- hands on hands on
    self.hands = {}
    for i = 1, 2 do
        self.hands[i] = Hand:new(self)
        self.hands[i]:equip(Peashooter:new())
    end

    self.hands[1].x = 8
    self.hands[1].y = 3

    self.hands[2].x = -1
end

function Player:update(dt)
    -- left/right movement
    if controls:down("left") then
        self.vx = math.max(-maxSpeed, self.vx - dt * (self.vx > 0 and brakeAccel or runAccel))
    elseif controls:down("right") then
        self.vx = math.min(maxSpeed, self.vx + dt * (self.vx < 0 and brakeAccel or runAccel))
    else
        local brake = dt * (self.vx < 0 and brakeAccel or -brakeAccel)
        if math.abs(brake) > math.abs(self.vx) then
            self.vx = 0
        else
            self.vx = self.vx + brake
        end
    end

    -- gravity
    self:addGravity(dt)

    -- jumping
    if self.onGround and controls:pressed("jump") then
        self.vy = -120
    end

    self.onGround = false

    self:movementUpdate(dt)
    
    -- shoot shoot
    if controls:pressed("shoot") then
        self:shoot()
    end
end

function Player:resolveCollision(other, nx, ny) -- also update onGround
    Entity.resolveCollision(self, nx, ny)
    
    if ny < 0 then 
        self.onGround = true
    end
end

function Player:shoot()
    for i = 1, 2 do
        self.hands[i]:shoot()
    end
end

function Player:draw()
    self.hands[1]:draw() -- left
    love.graphics.draw(img, self.x, self.y)
    self.hands[2]:draw() -- right
end


return Player
local Entity = require "class.Entity"
local Hand = require "class.Hand"
local Peashooter = require "class.guns.Peashooter"

local Player = class("Player", Entity)

local img = love.graphics.newImage("img/player.png")

local runAccel = 200
local brakeAccel = 500
local maxSpeed = 100

function Player:initialize(level, x, y)
    Entity.initialize(self, level, x, y, PLAYERWIDTH, PLAYERHEIGHT)

    self.dir = 1

    -- hands on hands on
    self.hands = {}
    for i = 1, 2 do
        self.hands[i] = Hand:new(self, i==2)
        self.hands[i]:equip(Peashooter:new())
    end

    self.hands[1].x = 8
    self.hands[1].y = 3

    self.hands[2].x = -1

    self.walkcycleTimer = 0
    self.walkcycle = 0

    self.transform = love.math.newTransform()
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

    if self.onGround or TURNAROUNDMIDAIR then -- allow turnaround
        if controls:down("left") then
            self.dir = -1
        end

        if controls:down("right") then
            self.dir = 1
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

    -- walk cycle animation
    if self.onGround then
        if self.vx ~= 0 then
            self.walkcycleTimer = self.walkcycleTimer + dt*8
            self.walkcycle = math.sin(self.walkcycleTimer)
        end
    end

    -- update transformation
    self.transform:reset()
    self.transform:translate(self.x, self.y)
    self.transform:translate(self.w*0.5, 0)
    self.transform:scale(self.dir, 1)
    self.transform:translate(-self.w*0.5, 0)

    for i = 1, 2 do
        self.hands[i]:updateTransformation(self.transform, self.walkcycle)
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
    love.graphics.draw(img, self.transform)
    self.hands[2]:draw() -- right
end


return Player
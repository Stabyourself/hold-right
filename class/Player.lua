local Entity = require "class.Entity"
local Player = class("Player", Entity)

local runAccel      = 200 -- the player acceleration while going left/right
local brakeAccel    = 500
local maxSpeed = 100

function Player:initialize(world, x, y)
    Entity.initialize(self, world, x, y, 8, 8)
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
    self.world.level:makeBullet(self, self.x+self.w, self.y+2, 150, 0)
end

return Player
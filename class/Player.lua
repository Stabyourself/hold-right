local Entity = require "class.Entity"
local Player = class("Player", Entity)

local runAccel      = 200 -- the player acceleration while going left/right
local brakeAccel    = 500
local maxSpeed = 100

function Player:initialize(world, x, y)
    Entity.initialize(self, world, x, y, 14, 14)
    self.onGround = false
end

function Player:update(dt)
    self:gravity(dt)

    -- movement  
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

    -- jumping
    if self.onGround and controls:pressed("up") then
        self.vy = -100
        self.onGround = false
    end

    local future_x = self.x + self.vx * dt
    local future_y = self.y + self.vy * dt
  
    local next_x, next_y, cols, len = self.world:move(self, future_x, future_y, self.filter)
  
    for i=1, len do
      local col = cols[i]
      self:collide(col.normal.x, col.normal.y, 0)
    end

    self.x = next_x
    self.y = next_y
end

return Player
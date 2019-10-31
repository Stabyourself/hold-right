local Entity = class("Entity")

local DEFAULT_GRAVITY = 200

function Entity.filter(item, other)
    local Bullet = require "class.Bullet"
    if other.isInstanceOf and other:isInstanceOf(Bullet) then -- is a bullet
        return false
    end
    
    if other.properties and other.properties.platform and item.y + item.h > other.y then 
        return false
    end

    return "slide"
end

function Entity:initialize(world, x, y, w, h)
    self.world = world
    self.x = x
    self.y = y
    self.w = w
    self.h = h

    self.vx = 0
    self.vy = 0

    world:add(self, x, y, w, h)
end

function Entity:draw()
    love.graphics.rectangle("line", self.x+.5, self.y+.5, self.w-1, self.h-1)
end

function Entity:movementUpdate(dt)
    local future_x = self.x + self.vx * dt
    local future_y = self.y + self.vy * dt
  
    local next_x, next_y, cols = self.world:move(self, future_x, future_y, self.filter)
  
    for _, col in ipairs(cols) do
        self:resolveCollision(col.other, col.normal.x, col.normal.y)
    end

    self.x = next_x
    self.y = next_y
end

function Entity:addGravity(dt, gravity)
    self.vy = self.vy + (gravity or DEFAULT_GRAVITY)*dt
end

function Entity:resolveCollision(nx, ny) -- default collision resolvement only sets speed to 0
    if (nx < 0 and self.vx > 0) or (nx > 0 and self.vx < 0) then
        self.vx = 0
    end

    if (ny < 0 and self.vy > 0) or (ny > 0 and self.vy < 0) then
        self.vy = 0
    end
end

function Entity:shotBy(bullet)
    
end

return Entity
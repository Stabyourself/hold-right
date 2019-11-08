local Entity = require "class.Entity"
local Bullet = class("Bullet", Entity)

function Bullet.filter(item, other)
    if item.owner == other then -- can't shoot yourself
        return false
    end

    return Entity.filter(item, other)
end

function Bullet:resolveCollision(other)
    if other.shotBy then
        other:shotBy(self)
    end

    self.delete = true -- remove bullet
end

function Bullet:initialize(world, owner, x, y, vx, vy)
    Entity.initialize(self, world, x-2, y-2, 4, 4)
    self.owner = owner

    self.vx = vx
    self.vy = vy
end

function Bullet:update(dt)
    self:movementUpdate(dt)
end

return Bullet

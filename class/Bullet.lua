local Entity = require "class.Entity"
local Bullet = class("Bullet", Entity)

function Bullet.filter(item, other)
    if item.owner == other then -- can't shoot yourself
        return false
    end

    if other.isInstanceOf and other:isInstanceOf(Bullet) then -- can't shoot other bullets
        return false
    end

    return "slide"
end

function Bullet:resolveCollision(other)
    if other.shotBy then 
        other:shotBy(item)
    end

    self.delete = true -- remove bullet
end

function Bullet:initialize(world, owner, x, y, vx, vy)
    Entity.initialize(self, world, x, y, 4, 4)
    self.owner = owner

    self.vx = vx
    self.vy = vy
end

function Bullet:update(dt)
    self:movementUpdate(dt)
end

return Bullet

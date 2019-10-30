local Entity = class("Entity")

local GRAVITY = 200

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

function Entity:gravity(dt)
    self.vy = self.vy + GRAVITY*dt
end

function Entity:collide(nx, ny, bounciness)
    bounciness = bounciness or 0
    local vx, vy = self.vx, self.vy

    if (nx < 0 and vx > 0) or (nx > 0 and vx < 0) then
    vx = -vx * bounciness
    end

    if (ny < 0 and vy > 0) or (ny > 0 and vy < 0) then
    vy = -vy * bounciness
    end

    self.vx, self.vy = vx, vy
    
    if ny < 0 then 
        self.onGround = true
    end
end

return Entity
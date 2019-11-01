local Gun = class("Gun")

Gun.barrelOffsetX = 0
Gun.barrelOffsetY = 0

function Gun:initialize(hand)
    self.hand = hand

    if hand then
        hand.gun = self
    end
end

function Gun:getPosition()
    return self.hand.transform:transformPoint(self.barrelOffsetX, self.barrelOffsetY)
end

function Gun:shoot()
    local x, y = self:getPosition()

    local speed = 150

    local vx = math.cos(self.hand.rotation)*speed*self.hand.player.dir
    local vy = math.sin(self.hand.rotation)*speed

    self.hand.player.level:makeBullet(self.hand.player, x, y, vx, vy)
end

function Gun:draw(transform)
    if self.img then
        love.graphics.draw(self.img, transform)
    end
end

return Gun

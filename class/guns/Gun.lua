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

    self.hand.player.level:makeBullet(self.hand.player, x, y, 150*self.hand.player.dir, 0)
end

function Gun:draw(transform)
    if self.img then
        love.graphics.draw(self.img, transform)
    end
end

return Gun

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
    local x, y = self.hand:getPosition()

    return x + self.barrelOffsetX, y + self.barrelOffsetY
end

function Gun:shoot()
    local x, y = self:getPosition()

    self.hand.player.level:makeBullet(self.hand.player, x, y, 150, 0)
end

function Gun:draw(x, y)
    if self.img then
        love.graphics.draw(self.img, x, y)
    end
end

return Gun
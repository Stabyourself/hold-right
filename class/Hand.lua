local Hand = class("Hand")

function Hand:initialize(player, inverted)
    self.x = 5
    self.y = 4
    self.gun = false
    self.player = player
    self.inverted = inverted

    self.rotation = 0
end

function Hand:updateTransformation(transform, walkcycle)
    self.transform = transform:clone()
    self.transform:translate(self:getLocalPosition())

    self.transform:translate(self:getWalkcycleOffset(walkcycle))

    self.transform:translate(self.gun.rotationOffsetX, self.gun.rotationOffsetY)
    self.transform:rotate(self.rotation)
    self.transform:translate(-self.gun.rotationOffsetX, -self.gun.rotationOffsetY)
end

function Hand:getWalkcycleOffset(walkcycle)
    local x = walkcycle*2
    local y = (1-math.abs(walkcycle))*1

    if self.inverted then
        x = -x
    end

    return x, y
end

function Hand:getPosition()
    local x, y = self.player.x, self.player.y

    return x + self.x, y + self.y
end

function Hand:getLocalPosition()
    return self.x, self.y
end

function Hand:draw()
    if self.gun then
        self.gun:draw(self.transform)
    else
        love.graphics.rectangle("line", x+.5, y+.5, 2, 3)
    end
end

function Hand:shoot()
    if self.gun then
        self.gun:shoot()
    end
end

function Hand:equip(gun)
    self.gun = gun
    self.gun.hand = self
end

return Hand
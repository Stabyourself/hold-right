local Hand = class("Hand")

function Hand:initialize(player)
    self.x = 5
    self.y = 4
    self.gun = false
    self.player = player
end

function Hand:getPosition()
    local x, y = self.player.x, self.player.y

    return x + self.x, y + self.y
end

function Hand:draw()
    local x, y = self:getPosition()

    if self.gun then
        self.gun:draw(x, y)
    end

    -- love.graphics.rectangle("line", x+.5, y+.5, 2, 3)
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
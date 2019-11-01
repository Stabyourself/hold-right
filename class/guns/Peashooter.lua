Gun = require "class.guns.Gun"
local Peashooter = class("Peashooter", Gun)

Peashooter.barrelOffsetX = 6
Peashooter.barrelOffsetY = -1

Peashooter.img = love.graphics.newImage("img/guns/peashooter.png")


function Peashooter:initialize(offX, offY, hand)
    Gun.initialize(self, offX, offY, hand)
end

return Peashooter
local postScaler = {}

function postScaler.init(w, h, scale)
    postScaler.w = w
    postScaler.h = h
    postScaler.scale = scale

    postScaler.canvas = love.graphics.newCanvas(w*scale, h*scale)
    postScaler.canvas:setFilter("nearest", "nearest")
end

function postScaler.preDraw()
    love.graphics.setCanvas(postScaler.canvas)
    love.graphics.clear()
end

function postScaler.postDraw()
    love.graphics.setCanvas()
    love.graphics.draw(postScaler.canvas, 0, 0, 0, postScaler.scale)
end

return postScaler

-- Debug thing for Mari0 2. Feel free to use it, MIT License

local FrameDebug3 = {}

local advanceDT = 1/60

local playing = true
local advanceFrame = false

local ffKeys = {
    {
        key = "+",
        val = 3
    },

    {
        key = "-",
        val = 0.1
    }
}

function FrameDebug3.update(dt)
    local mul = 1

    for _, ffKey in ipairs(ffKeys) do
        if love.keyboard.isDown(ffKey.key) then
            mul = mul * ffKey.val
        end
    end

    if not playing then
        if advanceFrame then
            advanceFrame = false

            return advanceDT*mul
        else
            return 0
        end
    end

    return dt*mul
end

function FrameDebug3.pausePlay()
    playing = not playing
end

function FrameDebug3.frameAdvance()
    playing = false
    advanceFrame = true
end

return FrameDebug3

local IMAGE_PATH = "resources/images/"
local lg = love.graphics

local IMAGE_FILES = {
    "ball", "platform"
}

img = {}

function loadResources()
    for i,v in ipairs(IMAGE_FILES) do
        img[v] = lg.newImage(IMAGE_PATH..v..".png")
    end
end

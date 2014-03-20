Platform = {
    DAMPING = 10,
    PLATFORM_WIDTH = 200,
    PLATFORM_HEIGHT = 25
}

Platform.__index = Platform

setmetatable(Platform, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Platform.new(world, x, y, image)
    local self = setmetatable({}, Platform)
    self.width = self.PLATFORM_WIDTH
    self.height = self.PLATFORM_HEIGHT
    self.image = image
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.body:setLinearDamping(self.DAMPING)
    self.shape = love.physics.newRectangleShape(0, 0, self.width, self.height)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    return self
end

function Platform.draw(self)
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(),
        self.body:getAngle(), 1, 1, self.width / 2, self.height / 2)
end

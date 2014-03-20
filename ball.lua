Ball = {
    RESTITUTION = 1,
    RADIUS = 10
}

Ball.__index = Ball

setmetatable(Ball, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function Ball.new(world, x, y, image)
    local self = setmetatable({}, Ball)
    self.image = image
    self.body = love.physics.newBody(world, x, y, "dynamic")
    self.body:setFixedRotation(true)
    self.shape = love.physics.newCircleShape(self.RADIUS)
    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.fixture:setRestitution(self.RESTITUTION)
    return self
end

function Ball.draw(self)
    love.graphics.draw(self.image, self.body:getX(), self.body:getY(),
        self.body:getAngle(), 1, 1, self.shape:getRadius(), self.shape:getRadius())
end

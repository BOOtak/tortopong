--resources
require("resources")

--physical objects
require("ball")
require("platform")

function love.load()
    loadResources()

    love.graphics.setColor(0,0,0)
    love.graphics.setBackgroundColor(255,255,255)
    screen_center_x = love.graphics.getWidth() / 2
    screen_center_y = love.graphics.getHeight() / 2
    circle_radius = love.graphics.getHeight() / 2 - 25
    platformx = screen_center_x
    platformy = screen_center_y + circle_radius
    force = 5000
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)

    objects = {}

    objects.platform = Platform(world, platformx, platformy, img.platform)

    objects.center = {}
    objects.center.body = love.physics.newBody(world, screen_center_x, screen_center_y)

    objects.ball = Ball(world, screen_center_x, screen_center_y, img.ball)

    love.physics.newDistanceJoint(objects.platform.body, objects.center.body,
        (objects.platform.body:getX() + objects.platform.PLATFORM_WIDTH / 2),
        objects.platform.body:getY(), objects.center.body:getX(), objects.center.body:getY())
    love.physics.newDistanceJoint(objects.platform.body, objects.center.body,
        (objects.platform.body:getX() - objects.platform.PLATFORM_WIDTH / 2),
        objects.platform.body:getY(), objects.center.body:getX(), objects.center.body:getY())
end

function love.draw()
    love.graphics.setColor(0,0,0)
    love.graphics.circle("line", screen_center_x, screen_center_y, circle_radius, 100)
    love.graphics.setColor(255,255,255)

    objects.ball:draw()
    objects.platform:draw()
end

function love.update(dt)

    world:update(dt)

    angle = math.atan2(screen_center_y - objects.platform.body:getY(),
        screen_center_x - objects.platform.body:getX()) + math.pi / 2
    force_x = force * math.cos(angle)
    force_y = force * math.sin(angle)

    if love.keyboard.isDown("left") then
        objects.platform.body:applyForce(-force_x, -force_y)
    end
    if love.keyboard.isDown("right") then
        objects.platform.body:applyForce(force_x, force_y)
    end
    if love.keyboard.isDown("a") then
        objects.ball.body:applyForce(0, 40)
    end
    if love.keyboard.isDown("r") then
        objects.ball.body:setX(screen_center_x)
        objects.ball.body:setY(screen_center_y)
    end
end

function love.load()
    paddle = love.graphics.newImage("paddle.png")
    ball_img = love.graphics.newImage("ball.png")
    love.graphics.setColor(0,0,0)
    love.graphics.setBackgroundColor(255,255,255)
    screen_center_x = love.graphics.getWidth() / 2
    screen_center_y = love.graphics.getHeight() / 2
    circle_radius = love.graphics.getHeight() / 2 - 25
    paddlex = screen_center_x
    paddley = screen_center_y + circle_radius
    img_width = 200
    img_height = 25
    force = 5000
    love.physics.setMeter(64)
    world = love.physics.newWorld(0, 0, true)

    objects = {}

    objects.paddle = {}
    objects.paddle.body = love.physics.newBody(world, paddlex, paddley, "dynamic")
    objects.paddle.body:setLinearDamping(10)
    objects.paddle.shape = love.physics.newRectangleShape(0, 0, img_width, img_height)
    objects.paddle.fixture = love.physics.newFixture(objects.paddle.body, objects.paddle.shape)

    objects.center = {}
    objects.center.body = love.physics.newBody(world, screen_center_x, screen_center_y)

    objects.ball = {}
    objects.ball.body = love.physics.newBody(world, screen_center_x, screen_center_y, "dynamic")
    objects.ball.body:setFixedRotation(true)
    objects.ball.shape = love.physics.newCircleShape(10)
    objects.ball.fixture = love.physics.newFixture(objects.ball.body, objects.ball.shape)
    objects.ball.fixture:setRestitution(1)

    love.physics.newDistanceJoint(objects.paddle.body, objects.center.body, objects.paddle.body:getX() + img_width / 2,
        objects.paddle.body:getY(), objects.center.body:getX(), objects.center.body:getY())
    love.physics.newDistanceJoint(objects.paddle.body, objects.center.body, objects.paddle.body:getX() - img_width / 2,
        objects.paddle.body:getY(), objects.center.body:getX(), objects.center.body:getY())
end

function love.draw()
    love.graphics.setColor(0,0,0)
    love.graphics.circle("line", screen_center_x, screen_center_y, circle_radius, 100)
    love.graphics.setColor(255,255,255)
    love.graphics.draw(paddle, objects.paddle.body:getX(), objects.paddle.body:getY(),
        objects.paddle.body:getAngle(), 1, 1, img_width/2, img_height/2)
    love.graphics.draw(ball_img, objects.ball.body:getX(), objects.ball.body:getY(),
        objects.ball.body:getAngle(), 1, 1, 10, 10)
end

function love.update(dt)

    world:update(dt)

    angle = math.atan2(screen_center_y - objects.paddle.body:getY(),
        screen_center_x - objects.paddle.body:getX()) + math.pi / 2
    force_x = force * math.cos(angle)
    force_y = force * math.sin(angle)

    if love.keyboard.isDown("left") then
        objects.paddle.body:applyForce(-force_x, -force_y)
    end
    if love.keyboard.isDown("right") then
        objects.paddle.body:applyForce(force_x, force_y)
    end
    if love.keyboard.isDown("a") then
        objects.ball.body:applyForce(0, 40)
    end
    if love.keyboard.isDown("r") then
        objects.ball.body:setX(screen_center_x)
        objects.ball.body:setY(screen_center_y)
    end
end

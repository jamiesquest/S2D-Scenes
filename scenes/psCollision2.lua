local composer = require("composer")
local relayout = require("libs.relayout")

-- Variables

local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local scene = composer.newScene()

local playerCircle
local goalCircle
local orbitCircle

local isColliding = false
local collisionLabel

local function touch(event)

    if event.phase == "began" then
        print("touched")
    end
end

local function checkCollisionCircle (obj1, obj2)
  local dist = math.abs(math.sqrt((obj2.x - obj1.x)^2 + (obj2.y - obj1.y)^2))
  local col = (dist < (obj1.path.radius + obj2.path.radius))
  return col
end

local function checkCollisionPartialCircle (circle1, point, angle)
  local dist = math.abs(math.sqrt((point.x - circle1.x)^2 + (point.y - circle1.y)^2))
  local col = dist < circle1.radius

  if col == true then
    local sideA, sideB, sideC = circle1.radius, dist, math.abs(math.sqrt((point.x - circle1.fvX)^2 + (point.y - circle1.fvY)^2))
    local angleC = math.deg(math.acos((sideA^2 + sideB^2 - sideC^2)/(2*sideA*sideB)))
    return angleC < (angle/2)
  end
end
---------------------------------------------------
-- UPDATE
---------------------------------------------------

local function update()
  --print("update")
  orbitCircle.orbit(2)
  goalCircle.rotate(1)
  if checkCollisionPartialCircle(goalCircle, orbitCircle, 90) == true then
    if isColliding == false then
      isColliding = true
    end
  else
    if isColliding == true then
      isColliding = false
    end
  end
  collisionLabel.update()
end

function listener1 (obj)
  print("listener 1 call")
end

function listener2 (obj)
  print("listener 2 call")
end

---------------------------------------------------
--Scene Creation
---------------------------------------------------

--create
function scene:create(event)
    print("GAME - Scene Create")

    local groupMain = self.view

    local title = display.newText("Game State", _CX, 100);
    groupMain:insert(title)

    local btnReturn = display.newText("Back To Menu...", _CX, _H - 50)
    groupMain:insert(btnReturn)

    btnReturn:addEventListener("tap", function()
        print("return to menu pressed")
        composer.gotoScene("scenes.menu")
    end)

    -- Goal Circle
    goalCircle = display.newImageRect( groupMain, "resources/partialCircle5.png", 128, 128 )
    goalCircle:setFillColor(1,1,1,0.2)
    goalCircle.x = _CX
    goalCircle.y = _CY
    goalCircle.radius = goalCircle.width/2
    goalCircle.fvX = goalCircle.x
    goalCircle.fvY = goalCircle.y - goalCircle.radius
    goalCircle.rotate = function( angle )
      local rot = goalCircle.rotation + angle
      if rot > 180 then
        rot = rot - 360
      elseif rot < -180 then
        rot = rot + 360
      end
      goalCircle.rotation = rot
      local s, c = math.sin(math.rad(goalCircle.rotation)), math.cos(math.rad(goalCircle.rotation))
      local x1, y1 = (goalCircle.x - goalCircle.x) * c - ((goalCircle.y - goalCircle.radius) - goalCircle.y) * s + goalCircle.x, (goalCircle.x - goalCircle.x) * s + ((goalCircle.y - goalCircle.radius) - goalCircle.y) * c + goalCircle.y
      goalCircle.fvX = x1
      goalCircle.fvY = y1
      --print("goal circle rotation: " .. tostring( goalCircle.rotation ))
    end
    --goalCircle.rotation = 45

    -- OrbitCircle
    orbitCircle = display.newCircle( groupMain, _CX, _CY+32, 2 )
    orbitCircle.pivX = goalCircle.x
    orbitCircle.pivY = goalCircle.y
    orbitCircle.orbit = function( angle )
      local s, c = math.sin(math.rad(angle)), math.cos(math.rad(angle))
      local x0, y0 = orbitCircle.x, orbitCircle.y
      local x1, y1 = (x0-orbitCircle.pivX) * c - (y0-orbitCircle.pivY)*s + orbitCircle.pivX, (x0-orbitCircle.pivX) * s + (y0-orbitCircle.pivY)*c + orbitCircle.pivY
      orbitCircle.x = x1
      orbitCircle.y = y1
    end

    collisionLabel = display.newText( groupMain, "Colliding: " .. tostring( isColliding ), _CX, 150 )
    collisionLabel.update = function()
      collisionLabel.text = "Colliding: " .. tostring( isColliding )
    end


    --Create event listeners
    Runtime:addEventListener("enterFrame", update)
    Runtime:addEventListener("touch", touch)

end

-- show
function scene:show(event)
    if(event.phase=="will")then
    elseif (event.phase == "did")then
    end
end

-- hide
function scene:hide(event)
    if(event.phase=="will")then
        print("GAME - scene being hidden")
        --Remove event listeners when hidden
        Runtime:removeEventListener("touch", touch)
        Runtime:removeEventListener("enterFrame", update)
    elseif(event.phase=="did")then
        print("GAME - scene is hidden")
    end
end

-- destroy
function scene:destroy(event)
    if(event.phase=="will")then
        print("GAME - scene being destroyed")
        Runtime:removeEventListener("touch", touch)
        Runtime:removeEventListener("enterFrame", update)
    end
end

-- event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

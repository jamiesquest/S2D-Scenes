local composer = require("composer")
local relayout = require("libs.relayout")

-- Variables

local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local scene = composer.newScene()

local function touch(event)

    if event.phase == "began" then
        print("touching")
    end
end

local function update()
    print("update")
end

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

    --Create event listeners
    Runtime:addEventListener("enterFrame", update)
    Runtime:addEventListener("touch", touch)

end

--show
function scene:show(event)
    if(event.phase=="will")then
    elseif (event.phase == "did")then
    end
end

--hide
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



local composer = require("composer")
local relayout = require("libs.relayout")

-- Variables

local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local scene = composer.newScene()

--create
function scene:create(event)
    print("SETTINGS - Scene Create")
    
    local groupMain = self.view

    local title = display.newText("settings menu", _CX, 100);
    groupMain:insert(title)

    local btnReturn = display.newText("Back To Menu...", _CX, _CY)
    groupMain:insert(btnReturn)

    btnReturn:addEventListener("tap", function()
        composer.gotoScene("scenes.menu")
    end)

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
        print("SETTINGS - scene being hidden")
    elseif(event.phase=="did")then
        print("SETTINGS - scene is hidden")
    end
end

-- destroy
function scene:destroy(event)
    if(event.phase=="will")then
        print("SETTINGS - scene being destroyed")
    end
end

-- event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene


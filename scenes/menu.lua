
local composer = require("composer")
local relayout = require("libs.relayout")

-- Variables

local _W, _H, _CX, _CY = relayout._W, relayout._H, relayout._CX, relayout._CY

local scene = composer.newScene()

--create
function scene:create(event)
    print("MENU - Scene Create")

    local groupMain = self.view

    local title = display.newText("main menu", _CX, 50);
    groupMain:insert(title)

    local btnPlay = display.newText("Tap to Start", _CX, _CY)
    groupMain:insert(btnPlay)

    local btnSettings = display.newText("settings", _CX, _H - 50)
    groupMain:insert(btnSettings)

    btnPlay:addEventListener("tap", function()
        composer.gotoScene("scenes.game")
    end)

    btnSettings:addEventListener("tap", function()
        composer.gotoScene("scenes.settings")
    end)


end

--show
function scene:show(event)
    if(event.phase=="will") then
    elseif (event.phase == "did") then
    end
end

--hide
function scene:hide(event)
    if(event.phase=="will")then
        print("MENU - scene being hidden")
    elseif(event.phase=="did")then
        print("MENU - scene is hidden")
    end
end

-- destroy
function scene:destroy(event)
    if(event.phase=="will")then
        print("MENU - scene being destroyed")
    end
end

-- event listeners
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene



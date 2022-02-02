
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

    -- Buttons
    local btnPlay = display.newText("Tap to Start", _CX, _CY)
    groupMain:insert(btnPlay)

    local btnPlay2 = display.newText( "Pie Slice Collision 1", _CX, _CY + 50 )
    groupMain:insert(btnPlay2)
    local btnPlay3 = display.newText( "Pie Slice Collision 2", _CX, _CY + 100 )
    groupMain:insert(btnPlay3)

    local btnSettings = display.newText("settings", _CX, _H - 50)
    groupMain:insert(btnSettings)

    --Button Event Listeners
    btnPlay:addEventListener("tap", function()
        composer.gotoScene("scenes.game2")
    end)

    btnPlay2:addEventListener("tap", function()
        composer.gotoScene("scenes.psCollision1")
    end)
    btnPlay3:addEventListener("tap", function()
        composer.gotoScene("scenes.psCollision2")
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

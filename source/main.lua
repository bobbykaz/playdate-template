import 'CoreLibs/graphics'
import 'CoreLibs/sprites'
import 'CoreLibs/crank'
import 'constants'
import 'attract-screen'
import 'demo-screen'
import 'save'
import 'log'
import 'system-menu'

local gfx = playdate.graphics
playdate.display.setRefreshRate( 30 )

gfx.setBackgroundColor( gfx.kColorWhite )

local firstRun = true

function loadSavedData()
  if SaveExists("example") then
    Log("Loading previously saved data")
    local tbl =  LoadData("example")
    LogTable(tbl)
  else
    Log("no save present")
  end
end

--local currentScreen = AttractScreen()
local currentScreen = DemoScreen()

function playdate.update()
  if firstRun then
    loadSavedData()
    InitMenu()
    firstRun = false
  end

  currentScreen:HandleUpdate()
end

function playdate.leftButtonDown()  currentScreen:HandleLeft()    end
function playdate.rightButtonDown() currentScreen:HandleRight()   end
function playdate.upButtonDown()    currentScreen:HandleUp()      end
function playdate.downButtonDown()  currentScreen:HandleDown()    end
function playdate.AButtonDown()     currentScreen:HandleAButton() end
function playdate.BButtonDown()     currentScreen:HandleBButton() end
function playdate.cranked(change, acceleratedChange)
  currentScreen:HandleCrank(change, acceleratedChange)
end

function HandleSavingState(mode)
  SaveData(mode)
end

function playdate.gameWillTerminate()
  currentScreen:HandleExit()
  HandleSavingState("terminate")
end
function playdate.deviceWillSleep()
  currentScreen:HandleExit()
  HandleSavingState("sleep")
end
function playdate.deviceWillLock()
  currentScreen:HandleExit()
  HandleSavingState("lock")
end

function ChangeScreen(newScreen)
  currentScreen:HandleExit()
  currentScreen = newScreen
end
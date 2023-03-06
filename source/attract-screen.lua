
import 'log'
import 'base-screen'
import 'demo-screen'

local gfx = playdate.graphics

local initMargin = -7
local margin = 3
local cellLength = 10

--row,col are 0-indexed!
local function drawBlankCell(row, col) 
    local rOffset = initMargin + (margin + cellLength) * row
    local cOffset = initMargin + (margin + cellLength) * col
    gfx.setColor( gfx.kColorBlack )
    gfx.drawRect(cOffset,rOffset,cellLength,cellLength)
end

--row,col are 0-indexed!
local function drawInvertedCell(row, col) 
  drawBlankCell(row, col)
  local rOffset = initMargin + (margin + cellLength) * row + 1
  local cOffset = initMargin + (margin + cellLength) * col + 1
  gfx.setColor( gfx.kColorXOR )
  gfx.fillRect(cOffset,rOffset,cellLength-2,cellLength-2)
  gfx.setColor( gfx.kColorBlack )
end

--row,col are 0-indexed!
local function drawMaybeCell(row, col) 
  drawBlankCell(row, col)
  local rOffset = initMargin + (margin + cellLength) * row + 1
  local cOffset = initMargin + (margin + cellLength) * col + 1
  gfx.setPattern(kMaybePattern)
  gfx.fillRect(cOffset,rOffset,cellLength-2,cellLength-2)
  gfx.setColor( gfx.kColorBlack )
end

local drawFnTable = {
        drawBlankCell,
        drawMaybeCell,
		    drawInvertedCell
	}

local redraw = true

local function clear()
  gfx.setColor(gfx.kColorWhite)
  gfx.fillRect(0,0,400,240)

  gfx.setColor( gfx.kColorBlack )
end

local function screenshot(suffix)
  local image = playdate.graphics.getWorkingImage()
  playdate.simulator.writeToFile(image, "builds/demo-attract"..suffix..".png")
end

local count = 0
local first = true;
class('AttractScreen').extends('Screen')

function AttractScreen:init()
  AttractScreen.super.init(self)
end

function AttractScreen:HandleUpdate()
  if redraw then
    clear()
    --gfx.drawRect(-1,-1,355,150)
    count += 1
    for i = 1,30,1
    do
      for j = 1,45,1
      do
        local idx = math.random(25)
        if first then
          idx = 1
        end
        --Log(idx)
        if idx < 17 then
          drawFnTable[1](i-1, j-1)
        elseif idx < 23 then
          drawFnTable[2](i-1, j-1)
        else
          drawFnTable[2](i-1, j-1)
        end
      end
    end
    screenshot(count)
    redraw = false
    first = false
  end
end

function AttractScreen:HandleAButton()
  redraw = true
end

function AttractScreen:HandleBButton()
  ChangeScreen(DemoScreen())
end
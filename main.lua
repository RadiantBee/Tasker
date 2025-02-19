--[[
    every task has these arguments:
    createDate|endDate|title|description|type|x|y|activeness|typeColorId
--]]
local Button = require('src/button')
local TaskList = require('src/taskList')
require('src/dialogWindow')

local taskList = TaskList()

local info = {
    "Tasker is an interactive To Do app",
    "You can write down your ideas and tasks",
    "You can change color of your type",
    "by pressing on empty button",
    "Alt clears text in active entry",
    "Author: Max Pan",
    "Version: 1.1.1"
}

local mouseX = 0
local mouseY = 0
local mouseState = 0

local newtaskDialog = CreateDialogWindowNewTask(400,200,nil,nil,taskList)
local infoDialog = CreateInfoWindow(200,200,260,info)

local createNewTaskButton = Button("+", function (dialog) dialog.active = not dialog.active end, newtaskDialog, 775, 5, 20, 20, {0.2,0.2,0.8}, {1,1,1}, "fill", {0.6,0.6,1}, {0,0,0})
local saveTaskListButton = Button("S", function (taskList) taskList:saveToFile() end, taskList, 775, 30, 20, 20, {0.2,0.2,0.8}, {1,1,1}, "fill", {0.6,0.6,1}, {0,0,0})
local infoButton = Button("i", function (dialog) infoDialog.active = not dialog.active end, infoDialog, 775, 55, 20, 20, {0.2,0.2,0.8}, {1,1,1}, "fill", {0.6,0.6,1}, {0,0,0})

function love.load()
    local bgColor = {}

    local colorFile = io.open(file or "colorConfig.txt", "r")
    if not colorFile then error("Cannot acces the colorConfig file") end
    for line in colorFile:lines("l") do
        table.insert(bgColor, line)
    end
    colorFile:close()

    love.graphics.setBackgroundColor(bgColor)

    taskList:loadFromFile()
end

function love.update()
    mouseX, mouseY = love.mouse.getPosition()
    taskList:update(mouseX,mouseY,mouseState)

    newtaskDialog:checkMouseMove(mouseX,mouseY,mouseState)
    infoDialog:checkMouseMove(mouseX,mouseY,mouseState)
    taskList.editDialog:checkMouseMove(mouseX,mouseY,mouseState)
end

function love.mousepressed()
    mouseState = 1
    taskList:onClick(mouseX, mouseY)
    createNewTaskButton:onClick(mouseX, mouseY)
    saveTaskListButton:onClick(mouseX, mouseY)
    infoButton:onClick(mouseX,mouseY)

    newtaskDialog:onClick(mouseX, mouseY)
    infoDialog:onClick(mouseX,mouseY)
    taskList.editDialog:onClick(mouseX,mouseY)
end

function love.mousereleased()
    mouseState = 0
end

function love.quit()
    taskList:saveToFile()
end

function love.keypressed(key)
    newtaskDialog:onKeyboardPress(key)
    taskList.editDialog:onKeyboardPress(key)
end

function love.draw()
    taskList:draw(mouseX, mouseY)
    createNewTaskButton:draw(nil,nil,mouseX,mouseY,5,1.5)
    saveTaskListButton:draw(nil,nil,mouseX,mouseY,6,3)
    infoButton:draw(nil,nil,mouseX,mouseY,8,3)

    newtaskDialog:draw(mouseX,mouseY)
    infoDialog:draw(mouseX,mouseY)
    taskList.editDialog:draw(mouseX,mouseY)
end

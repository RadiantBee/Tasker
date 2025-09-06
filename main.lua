--[[
    every task has these arguments:
    createDate|endDate|title|description|type|x|y|activeness|typeColorId
--]]
local Button = require("src/button")
local TaskList = require("src/taskList")
local push = require("libs/push")
require("src/dialogWindow")

local taskList = TaskList()

local info = {
	"Tasker is an interactive To Do app",
	"You can write down your ideas and tasks",
	"You can change color of your type",
	"by pressing on empty button",
	"Alt clears text in active entry",
	"Author: Max Pan",
	"Version: 1.1.1",
}

local user = {}
user.mouse = {}
user.mouse.x = 0
user.mouse.y = 0
user.mouse.state = 0

local newtaskDialog = CreateDialogWindowNewTask(400, 200, nil, nil, taskList)
local infoDialog = CreateInfoWindow(200, 200, 260, info)

-- UI Buttons
local createNewTaskButton = Button(
	"+",
	function(dialog)
		dialog.active = not dialog.active
	end,
	newtaskDialog,
	775,
	5,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"create",
	-45,
	3
)
local saveTaskListButton = Button(
	"S",
	function(taskList)
		taskList:saveToFile()
	end,
	taskList,
	775,
	30,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"save",
	-35,
	3
)
local infoButton = Button(
	"i",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	55,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"info",
	-30,
	3
)

local hostButton = Button(
	"H",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	105,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"host",
	-32,
	3
)
local joinButton = Button(
	"j",
	function(dialog)
		infoDialog.active = not dialog.active
	end,
	infoDialog,
	775,
	130,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"join",
	-30,
	3
)
local disconnectButton = Button(
	"D",
	function(dialog)
		infoDialog.active = not dialog.active
	end,
	infoDialog,
	775,
	155,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"disconnect",
	-72,
	3
)

local save1Button = Button(
	"1",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	205,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 1",
	-45,
	3
)
local save2Button = Button(
	"2",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	230,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 2",
	-45,
	3
)
local save3Button = Button(
	"3",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	255,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 3",
	-45,
	3
)
local save4Button = Button(
	"4",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	280,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 4",
	-45,
	3
)
local save5Button = Button(
	"5",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	305,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 5",
	-45,
	3
)
local save6Button = Button(
	"6",
	function(dialog)
		dialog.active = not dialog.active
	end,
	infoDialog,
	775,
	330,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"Save 6",
	-45,
	3
)
local clearButton = Button(
	"c",
	function(dialog)
		infoDialog.active = not dialog.active
	end,
	infoDialog,
	775,
	380,
	20,
	20,
	{ 0.2, 0.2, 0.8 },
	{ 1, 1, 1 },
	"fill",
	{ 0.6, 0.6, 1 },
	{ 0, 0, 0 },
	nil,
	nil,
	nil,
	nil,
	"clear save",
	-70,
	3
)

local configData = {}
--[[
-- 1 - bg R
-- 2 - bg G
-- 3 - bg B
-- 4 - Nickname
-- 5 - mouse R
-- 6 - mouse G
-- 7 - mouse B
--]]
function love.load()
	local appWidth, appHeight = love.graphics.getDimensions()
	push:setupScreen(appWidth, appHeight, appWidth, appHeight, { vsync = 0, resizable = true, stretched = false })
	love.graphics.setDefaultFilter("nearest", "nearest")

	local colorFile = io.open("config", "r")
	if not colorFile then
		error("Cannot acces the colorConfig file")
	end
	for line in colorFile:lines("l") do
		table.insert(configData, line)
	end
	colorFile:close()

	push:setBorderColor(configData[1], configData[2], configData[3])
	taskList:loadFromFile()
end
function love.resize(w, h)
	return push:resize(w, h)
end
function love.update()
	user.mouse.x, user.mouse.y = love.mouse.getPosition()

	if push:toGame(user.mouse.x, user.mouse.y) then
		user.mouse.x, user.mouse.y = push:toGame(user.mouse.x, user.mouse.y)
	end

	taskList:update(user.mouse.x, user.mouse.y, user.mouse.state)

	newtaskDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
	infoDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
	taskList.editDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
end

function love.mousepressed()
	user.mouse.state = 1
	taskList:onClick(user.mouse.x, user.mouse.y)
	createNewTaskButton:onClick(user.mouse.x, user.mouse.y)
	saveTaskListButton:onClick(user.mouse.x, user.mouse.y)
	infoButton:onClick(user.mouse.x, user.mouse.y)

	newtaskDialog:onClick(user.mouse.x, user.mouse.y)
	infoDialog:onClick(user.mouse.x, user.mouse.y)
	taskList.editDialog:onClick(user.mouse.x, user.mouse.y)
end

function love.mousereleased()
	user.mouse.state = 0
end

function love.quit()
	taskList:saveToFile()
end

function love.keypressed(key)
	newtaskDialog:onKeyboardPress(key)
	taskList.editDialog:onKeyboardPress(key)
end

function love.draw()
	push:start()

	taskList:draw(user.mouse.x, user.mouse.y)

	-- UI buttons
	createNewTaskButton:draw(nil, nil, user.mouse.x, user.mouse.y, 5, 1.5)
	saveTaskListButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	infoButton:draw(nil, nil, user.mouse.x, user.mouse.y, 9, 3)
	hostButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	joinButton:draw(nil, nil, user.mouse.x, user.mouse.y, 9, 3)
	disconnectButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	clearButton:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save1Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save2Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save3Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save4Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save5Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save6Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)

	-- Pop-up windows
	newtaskDialog:draw(user.mouse.x, user.mouse.y)
	infoDialog:draw(user.mouse.x, user.mouse.y)
	infoDialog:draw(user.mouse.x, user.mouse.y)
	taskList.editDialog:draw(user.mouse.x, user.mouse.y)

	push:finish()
end

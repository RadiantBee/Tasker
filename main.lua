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

local newtaskDialog = CreateDialogWindowNewTask(400, 20, nil, nil, taskList)
local infoDialog = CreateInfoWindow(100, 20, 260, info)
--local joinDialog = CreateJoinWindow(400, 250, nil, nil, taskList)
--local hostDialog = CreateHostWindow(150, 180, nil, nil, taskList)

local clearSaveDialog = CreateClearSaveWindow(500, 350, nil, nil, taskList)
-- UI Buttons
local saveButtonList = {}
saveButtonList.idlePassiveSaveColor = { 0.2, 0.2, 0.8 }
saveButtonList.idlePassiveSaveTextColor = { 1, 1, 1 }
saveButtonList.highlightedPassiveSaveColor = { 0.6, 0.6, 1 }
saveButtonList.idleActiveSaveColor = { 1, 1, 0.2 }
saveButtonList.idleActiveSaveTextColor = { 0, 0, 0 }
saveButtonList.highlightedActiveSaveColor = { 1, 1, 0.8 }

saveButtonList.updateColors = function(self, activeSave)
	for index, saveButton in ipairs(self) do
		if index == activeSave then
			saveButton.colorIdle = self.idleActiveSaveColor
			saveButton.colorTextIdle = self.idleActiveSaveTextColor
			saveButton.colorHighlighted = self.highlightedActiveSaveColor
		else
			saveButton.colorIdle = self.idlePassiveSaveColor
			saveButton.colorTextIdle = self.idlePassiveSaveTextColor
			saveButton.colorHighlighted = self.highlightedPassiveSaveColor
		end
	end
end

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
--[[
local hostButton = Button(
	"H",
	function(dialog)
		dialog.active = not dialog.active
	end,
	hostDialog,
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
		dialog.active = not dialog.active
	end,
	joinDialog,
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
--]]
local save1Button = Button(
	"1",
	function(args)
		args[1]:changeSaveFile(1)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
	775,
	105,
	20,
	20,
	{ 1, 1, 0.2 },
	{ 0, 0, 0 },
	"fill",
	{ 1, 1, 0.8 },
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
	function(args)
		args[1]:changeSaveFile(2)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
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
	"Save 2",
	-45,
	3
)
local save3Button = Button(
	"3",
	function(args)
		args[1]:changeSaveFile(3)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
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
	"Save 3",
	-45,
	3
)
local save4Button = Button(
	"4",
	function(args)
		args[1]:changeSaveFile(4)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
	775,
	180,
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
	function(args)
		args[1]:changeSaveFile(5)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
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
	"Save 5",
	-45,
	3
)
local tempSaveButton = Button(
	"t",
	function(args)
		args[1]:changeSaveFile(6)
		args[2]:updateColors(args[1].currentSave)
	end,
	{ taskList, saveButtonList },
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
	"Temp save",
	-70,
	3
)
local clearButton = Button(
	"c",
	function(dialog)
		dialog.active = not dialog.active
	end,
	clearSaveDialog,
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
	"clear save",
	-70,
	3
)
saveButtonList[1] = save1Button
saveButtonList[2] = save2Button
saveButtonList[3] = save3Button
saveButtonList[4] = save4Button
saveButtonList[5] = save5Button
saveButtonList[6] = tempSaveButton

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
	--joinDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
	--hostDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
	clearSaveDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
	taskList.editDialog:checkMouseMove(user.mouse.x, user.mouse.y, user.mouse.state)
end

function love.mousepressed()
	user.mouse.state = 1
	taskList:onClick(user.mouse.x, user.mouse.y)
	createNewTaskButton:onClick(user.mouse.x, user.mouse.y)
	saveTaskListButton:onClick(user.mouse.x, user.mouse.y)
	infoButton:onClick(user.mouse.x, user.mouse.y)
	--hostButton:onClick(user.mouse.x, user.mouse.y)
	--joinButton:onClick(user.mouse.x, user.mouse.y)
	--disconnectButton:onClick(user.mouse.x, user.mouse.y)
	clearButton:onClick(user.mouse.x, user.mouse.y)
	save1Button:onClick(user.mouse.x, user.mouse.y)
	save2Button:onClick(user.mouse.x, user.mouse.y)
	save3Button:onClick(user.mouse.x, user.mouse.y)
	save4Button:onClick(user.mouse.x, user.mouse.y)
	save5Button:onClick(user.mouse.x, user.mouse.y)
	tempSaveButton:onClick(user.mouse.x, user.mouse.y)

	newtaskDialog:onClick(user.mouse.x, user.mouse.y)
	infoDialog:onClick(user.mouse.x, user.mouse.y)
	--joinDialog:onClick(user.mouse.x, user.mouse.y)
	--hostDialog:onClick(user.mouse.x, user.mouse.y)
	clearSaveDialog:onClick(user.mouse.x, user.mouse.y)
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
	--joinDialog:onKeyboardPress(key)
	--hostDialog:onKeyboardPress(key)
	taskList.editDialog:onKeyboardPress(key)
end

function love.draw()
	push:start()

	taskList:draw(user.mouse.x, user.mouse.y)

	-- UI buttons
	createNewTaskButton:draw(nil, nil, user.mouse.x, user.mouse.y, 5, 1.5)
	saveTaskListButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	infoButton:draw(nil, nil, user.mouse.x, user.mouse.y, 9, 3)
	--hostButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	--joinButton:draw(nil, nil, user.mouse.x, user.mouse.y, 9, 3)
	--disconnectButton:draw(nil, nil, user.mouse.x, user.mouse.y, 6, 3)
	clearButton:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save1Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save2Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save3Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save4Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	save5Button:draw(nil, nil, user.mouse.x, user.mouse.y, 7, 2)
	tempSaveButton:draw(nil, nil, user.mouse.x, user.mouse.y, 8, 2)

	-- Pop-up windows
	newtaskDialog:draw(user.mouse.x, user.mouse.y)
	infoDialog:draw(user.mouse.x, user.mouse.y)
	--joinDialog:draw(user.mouse.x, user.mouse.y)
	--hostDialog:draw(user.mouse.x, user.mouse.y)

	clearSaveDialog:draw(user.mouse.x, user.mouse.y)
	taskList.editDialog:draw(user.mouse.x, user.mouse.y)

	push:finish()
end

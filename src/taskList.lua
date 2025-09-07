local Button = require("src/button")
require("src/dialogWindow")

local function split(s, delimiter)
	local result = {}
	for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
		table.insert(result, match)
	end
	return result
end

local function Task(argTable, taskList)
	local task = {}
	task.title = argTable[1] or "noTitle"
	task.description1 = argTable[2] or ""
	task.description2 = argTable[3] or ""
	task.description3 = argTable[4] or ""
	task.description4 = argTable[5] or ""
	task.type = argTable[6] or "noType"

	task.x = tonumber(argTable[7]) or 100
	task.y = tonumber(argTable[8]) or 100

	task.active = argTable[9] == "1"
	task.typeColorId = tonumber(argTable[10]) or 1

	task.typeColors =
		{ { 0.5, 0.5, 0.5 }, { 0.8, 0, 0 }, { 0, 0.8, 0 }, { 0.5, 0.5, 1 }, { 0.8, 0.8, 0 }, { 0.8, 0, 0.8 } }

	task.changeTypeColor = function(self)
		self.typeColorId = self.typeColorId + 1
		if self.typeColorId > #self.typeColors then
			self.typeColorId = 1
		end
	end

	task.titleHeight = 20

	task.width = 100
	task.height = 85

	task.readyToDelete = false

	task.writeActiveness = function(self)
		if self.active then
			return "1"
		end
		return "0"
	end

	task.deleteButtonColor = function(self)
		if self.readyToDelete then
			self.deleteButton.modeIdle = "fill"
			self.deleteButton.colorIdle = { 0.4, 0, 0 }
			self.deleteButton.colorHighlighted = { 0.7, 0, 0 }
			self.deleteButton.colorActive = { 1, 0, 0 }
		else
			self.deleteButton.modeIdle = "line"
			self.deleteButton.colorIdle = { 1, 1, 1 }
			self.deleteButton.colorHighlighted = { 0.4, 0.4, 0.4 }
			self.deleteButton.colorActive = { 1, 1, 1 }
		end
	end

	task.activeButton = Button(task.active and "^" or "V", function(self)
		self.active = not self.active
		self.readyToDelete = false
		self:deleteButtonColor()

		self.deleteButton.colorIdle = { 1, 1, 1 }
		self.deleteButton.modeIdle = "line"
		self.deleteButton.colorHighlighted = { 0.4, 0.4, 0.4 }
		self.deleteButton.colorActive = { 1, 1, 1 }

		if self.active then
			self.activeButton.text = "^"
		else
			self.activeButton.text = "V"
		end
	end, task, nil, nil, 20, 20)

	task.deleteButton = Button("X", function(argTable)
		if argTable[2].readyToDelete then
			for id, task in pairs(argTable[1].tasks) do
				if
					task.title == argTable[2].title
					and task.description1 == argTable[2].description1
					and task.description2 == argTable[2].description2
					and task.description3 == argTable[2].description3
					and task.description4 == argTable[2].description4
					and task.type == argTable[2].type
				then
					table.remove(argTable[1].tasks, id)
					argTable[1]:saveToFile()
					break
				end
			end
		else
			argTable[2].readyToDelete = true
			argTable[2]:deleteButtonColor()
		end
	end, { taskList, task }, nil, nil, 20, 20)

	task.colorChangeButton = Button("", function(self)
		self:changeTypeColor()
		self.colorChangeButton.colorHighlighted = self.typeColors[self.typeColorId]
	end, task, nil, nil, 20, 20, nil, nil, nil, task.typeColors[task.typeColorId])

	task.editButton = Button("E", function(args)
		args[2].editDialog.task = args[1]
		args[2].editDialog.saveButton.funcArgs = { args[2].editDialog, args[2] }
		args[2].editDialog.entryTitle.text = args[1].title
		args[2].editDialog.entryType.text = args[1].type
		args[2].editDialog.entryDescription1.text = args[1].description1
		args[2].editDialog.entryDescription2.text = args[1].description2
		args[2].editDialog.entryDescription3.text = args[1].description3
		args[2].editDialog.entryDescription4.text = args[1].description4
		args[2].editDialog.active = not args[2].editDialog.active
	end, { task, taskList }, nil, nil, 20, 20)

	task.checkHighlightedTitle = function(self, mouseX, mouseY)
		if mouseX and mouseY then
			if (mouseX > self.x) and (mouseX < self.x + self.width) then
				if (mouseY > self.y) and (mouseY < self.y + self.titleHeight) then
					return true
				end
			end
		end
		return false
	end

	task.checkHighlighted = function(self, mouseX, mouseY)
		if (mouseX > self.x) and (mouseX < self.x + self.width) then
			if (mouseY > self.y) and (mouseY < self.y + self.height) then
				return true
			end
		end
		return false
	end

	task.checkMouseMove = function(self, mouseX, mouseY, mouseState)
		if (mouseX > self.x) and (mouseX < self.x + self.width - self.activeButton.width) then
			if (mouseY > self.y) and (mouseY < self.y + self.titleHeight) then
				if mouseState == 1 then
					self.x = mouseX - self.width / 2
					self.y = mouseY - self.titleHeight / 2
					self.readyToDelete = false
					self:deleteButtonColor()
				end
			end
		end
	end

	task.draw = function(self, mouseX, mouseY)
		self.x = self.x or 0
		self.y = self.y or 0

		if self.active then
			love.graphics.setColor(0, 0, 0)
			love.graphics.rectangle("fill", self.x, self.y, self.width, self.titleHeight + self.height)
			love.graphics.setColor(1, 1, 1)
			love.graphics.rectangle("line", self.x, self.y, self.width, self.titleHeight + self.height)
			love.graphics.print(self.description1, self.x + 3, self.y + self.titleHeight + 3)
			love.graphics.print(self.description2, self.x + 3, self.y + self.titleHeight + 3 + 15)
			love.graphics.print(self.description3, self.x + 3, self.y + self.titleHeight + 3 + 30)
			love.graphics.print(self.description4, self.x + 3, self.y + self.titleHeight + 3 + 45)

			self.deleteButton:draw(
				self.x + self.width - self.deleteButton.width,
				self.y + self.titleHeight + self.height - self.deleteButton.height,
				mouseX,
				mouseY,
				6,
				3
			)
			self.editButton:draw(
				self.x,
				self.y + self.titleHeight + self.height - self.deleteButton.height,
				mouseX,
				mouseY,
				6,
				3
			)
			self.colorChangeButton:draw(
				self.x + self.width / 2 - self.deleteButton.width / 2,
				self.y + self.titleHeight + self.height - self.deleteButton.height,
				mouseX,
				mouseY,
				6,
				3
			)
		end
		love.graphics.setColor(0, 0, 0)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.titleHeight)
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.titleHeight)
		love.graphics.print(self.title, self.x + 3, self.y + 3)

		love.graphics.setColor(self.typeColors[self.typeColorId])
		love.graphics.print(self.type, self.x + 43, self.y + 3)

		self.activeButton:draw(self.x + self.width - self.activeButton.width, self.y, mouseX, mouseY, 5, 3)
	end

	task.onClick = function(self, mouseX, mouseY)
		self.activeButton:onClick(mouseX, mouseY)
		self.deleteButton:onClick(mouseX, mouseY)
		self.colorChangeButton:onClick(mouseX, mouseY)
		self.editButton:onClick(mouseX, mouseY)
	end

	return task
end

local function TaskList()
	local taskList = {}

	taskList.currentSave = 1

	taskList.tasks = {}

	taskList.editDialog = CreateDialogEditTask(100, 100, nil, nil, nil, taskList)

	taskList.loadFromFile = function(self, file)
		local taskFile = io.open(file or "save1", "r")
		if not taskFile then
			error("Cannot acces the save file")
		end
		for line in taskFile:lines("l") do
			table.insert(self.tasks, Task(split(line, "|"), self))
		end
		taskFile:close()
	end

	taskList.saveToFile = function(self, file)
		local taskFile = io.open(file or "save1", "w")
		if not taskFile then
			error("Cannot acces the save file")
		end
		for _, task in pairs(self.tasks) do
			taskFile:write(
				task.title
					.. "|"
					.. task.description1
					.. "|"
					.. task.description2
					.. "|"
					.. task.description3
					.. "|"
					.. task.description4
					.. "|"
					.. task.type
					.. "|"
					.. task.x
					.. "|"
					.. task.y
					.. "|"
					.. task:writeActiveness()
					.. "|"
					.. task.typeColorId
					.. "\n"
			)
		end
		taskFile:close()
	end

	taskList.onClick = function(self, mouseX, mouseY)
		for _, task in pairs(self.tasks) do
			task:onClick(mouseX, mouseY)
		end
	end

	taskList.update = function(self, mouseX, mouseY, mouseState)
		for _, task in pairs(self.tasks) do
			if task:checkHighlightedTitle(mouseX, mouseY) then
				task:checkMouseMove(mouseX, mouseY, mouseState)
				break
			end
		end
	end

	taskList.draw = function(self, mouseX, mouseY)
		for _, task in pairs(self.tasks) do
			task:draw(mouseX, mouseY)
		end
	end

	taskList.addTask = function(self, argTable)
		table.insert(self.tasks, Task(argTable, self))
		self:saveToFile()
	end

	return taskList
end

return TaskList

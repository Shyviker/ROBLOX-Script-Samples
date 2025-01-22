-- Spectate script (localScript)

local runService = game:GetService("RunService")
local playerService = game:GetService("Players")
local contextActionService = game:GetService("ContextActionService")

-- Wait for character to load
local char = playerService.LocalPlayer.Character or playerService.LocalPlayer.CharacterAdded:Wait()

local camera = game.Workspace.CurrentCamera -- Get localPlayer camera

local gui = script.Parent
local spectButton = gui:WaitForChild("TextButton")
local touchFrame = gui:WaitForChild("touchFrame")

local playerTable = playerService:GetPlayers()
local index = 1
touchFrame.TextLabel.Text = playerService.LocalPlayer.Name -- Default spec name is local player's

local function switch(code) -- Switch for better optimisation
	return code
end

local playerSwitch = switch({
	["RIGHT_SWITCH"] = function()
		if index >= #playerTable then
			index = 1
			return
		end
		index += 1
	end,
	["LEFT_SWITCH"] = function()
		if index <= 1 then
			index = #playerTable
			return
		end
		index -= 1
	end,
})

local function switchSpec(actionName, inputState)
	if inputState == Enum.UserInputState.Begin then
		if playerSwitch[actionName] then
			playerSwitch[actionName]()
			camera.CameraSubject = playerTable[index].Character.Humanoid
			touchFrame.TextLabel.Text = playerTable[index].Name
			print(index)
		end
	end
end

local spectate = false
spectButton.MouseButton1Click:Connect(function()
	if spectate == false then
		spectate = true
		touchFrame.Visible = true
		
		contextActionService:BindAction("RIGHT_SWITCH", switchSpec, false, Enum.KeyCode.E)
		contextActionService:BindAction("LEFT_SWITCH", switchSpec, false, Enum.KeyCode.Q)
		
		-- Mouse click arrow buttons
		
		touchFrame.rightButton.MouseButton1Click:Connect(function()
			switchSpec("RIGHT_SWITCH", Enum.UserInputState.Begin)
		end)
		touchFrame.leftButton.MouseButton1Click:Connect(function()
			switchSpec("LEFT_SWITCH", Enum.UserInputState.Begin)
		end)
		
		-- TouchScreen tap arrow buttons
		
		touchFrame.rightButton.TouchTap:Connect(function()
			switchSpec("RIGHT_SWITCH", Enum.UserInputState.Begin)
		end)
		touchFrame.leftButton.TouchTap:Connect(function()
			switchSpec("LEFT_SWITCH", Enum.UserInputState.Begin)
		end)
	else
		spectate = false
		touchFrame.Visible = false
		contextActionService:UnbindAction("RIGHT_SWITCH")
		contextActionService:UnbindAction("LEFT_SWITCH")
		camera.CameraSubject = char.Humanoid
	end
end)

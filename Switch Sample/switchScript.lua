-- Using switches to help with checking for multiple conditionals
-- Improves script performance and removes the need for unnecessary input check
-- LocalScript located at StarterCharacterScripts

local userInput = game:GetService("UserInputService")

local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")

function switch(code) -- The switch
	return code
end

--  Add conditions

userSwitch = switch({
	[Enum.KeyCode.E] = function()
		hum.WalkSpeed += 10
	end,
	[Enum.KeyCode.Q] = function()
		hum.WalkSpeed -= 10
	end,
	[Enum.KeyCode.LeftShift] = function()
		if userInput:IsKeyDown(Enum.KeyCode.LeftShift) then
			hum.WalkSpeed += 100
		else
			hum.WalkSpeed -= 100
		end
	end,
	[Enum.KeyCode.R] = function()
		hum.Health = 0
		print("Reset instantly")
	end,
})

userInput.InputBegan:Connect(function(input, gameEvent)
	if userSwitch[input.KeyCode] and gameEvent == false then
		userSwitch[input.KeyCode]() -- Run the functions
	end
end)

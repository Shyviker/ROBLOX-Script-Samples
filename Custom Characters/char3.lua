-- Adding attributes and abilities to custom rigs. All we need is a module and a switch table full of custom functions for each rig.
-- LocalScript located inside the character model

local userInput = game:GetService("UserInputService")
local module = require(game:GetService("ReplicatedStorage"):WaitForChild("customCharacters"))
local hum = script.Parent:WaitForChild("Humanoid")

--------------------------------------------
-- This character is called: DAN THE MAN

local canUseUlt = false

local abilities = module.Switch({
	[Enum.KeyCode.Space] = function()
		print("Fire weapon")
	end,
	[Enum.KeyCode.Z] = function()
		print("Normal attack")
		local prevTime = DateTime.now()
		while userInput:IsKeyDown(Enum.KeyCode.Z) do
			local current_time = DateTime.now()
			if current_time.UnixTimestamp - prevTime.UnixTimestamp >= 2 then
				canUseUlt = true -- Charged attack
			end
			task.wait()
		end
	end,
	[Enum.KeyCode.X] = function()
		print("Grab")
	end,
})
module.characterDesc(abilities)

-- Release charged attack
userInput.InputEnded:Connect(function(input, gameEvent)
	if input.KeyCode == Enum.KeyCode.Z and gameEvent == false and canUseUlt then
		print("ULTIMATE ATTACK!")
		canUseUlt = false
	end
end)

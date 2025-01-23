-- Code to streamline adding custom character abilities
-- ModuleScript located at ReplicatedStorage

local userInput = game:GetService("UserInputService")

local module = {}

function module.Switch(code) -- Switch that we can add abilities in
	return code
end

function module.characterDesc(abilities)
	userInput.InputBegan:Connect(function(input, gameEvent)
		if abilities[input.KeyCode] and gameEvent == false then
			abilities[input.KeyCode]()
		end
	end)
end
return module

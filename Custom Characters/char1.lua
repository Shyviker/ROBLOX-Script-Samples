-- Adding attributes and abilities to custom rigs. All we need is a module and a switch table full of custom functions for each rig.
-- LocalScript located inside the character model

local userInput = game:GetService("UserInputService")
local module = require(game:GetService("ReplicatedStorage"):WaitForChild("customCharacters"))
local hum = script.Parent:WaitForChild("Humanoid")

--------------------------------------------
-- This character is called: GUY DANGEROUS

local DEFAULT_SPEED = 16
local can_heal = true
local can_dash = true

local abilities = module.Switch({
	[Enum.KeyCode.LeftShift] = function()
		repeat 
			hum.WalkSpeed = 32
			task.wait()
		until not userInput:IsKeyDown(Enum.KeyCode.LeftShift)
		hum.WalkSpeed = DEFAULT_SPEED
	end,
	[Enum.KeyCode.E] = function()
		if can_heal then
			hum.Health += 35
			can_heal = false
			task.wait(10)
			can_heal = true
		end
	end,
	[Enum.KeyCode.Q] = function()
		if can_dash then
			hum.WalkSpeed = 50
			can_dash = false
			task.wait(0.75)
			hum.WalkSpeed = DEFAULT_SPEED
			can_dash = true
		end
	end,
})
module.characterDesc(abilities)

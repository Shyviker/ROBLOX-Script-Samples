-- Adding attributes and abilities to custom rigs. All we need is a module and a switch table full of custom functions for each rig.
-- LocalScript located inside the character model

local userInput = game:GetService("UserInputService")
local module = require(game:GetService("ReplicatedStorage"):WaitForChild("customCharacters"))
local hum = script.Parent:WaitForChild("Humanoid")

--------------------------------------------
-- This character is called: CORVO ATTANO

local mana = 100

local function reductMana(manaCost)
	if (mana - manaCost) > 0 then
		mana -= manaCost
	end
end

local abilities = module.Switch({
	[Enum.KeyCode.E] = function()
		print("Crossbow equipped")
	end,
	[Enum.KeyCode.Two] = function()
		reductMana(15)
		print("Blink used")
	end,
	[Enum.KeyCode.Three] = function()
		reductMana(60)
		print("Bend time used")
	end,
})
module.characterDesc(abilities)

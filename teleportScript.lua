-- Simple teleport script directed only from Server end!
-- Uses parts that act as regions for teleporting, called 'teleParts'
-- Player must step into teleport part, wait for the number of players to be equal to the limit, then be teleported

-- This uses the SafeTeleport module provided by Roblox. You can check it out here:
-- https://create.roblox.com/docs/projects/teleporting#handling-failed-teleports

local SafeTeleport = require(game:GetService("ReplicatedStorage"):WaitForChild("safeTeleport"))

local placeID = 127116206580287
local teleParts = workspace:WaitForChild("teleParts")

local limit = 1 -- Minimum number of players required for teleport

for _, telePart in pairs(teleParts:GetChildren()) do
	local telePartLabel = telePart:WaitForChild("BillboardGui"):WaitForChild("TextLabel")
	telePartLabel.Text = "Players: 0/" .. tostring(limit)
	local touched = false
	local inTelePart = {} -- Every part in the telepart
	local playersTable = {} -- Each player in inTelePart
	
	telePart.Touched:Connect(function(otherPart)
		
		if otherPart.Parent:FindFirstChild("Humanoid") and touched == false then
			touched = true
			local player = game:GetService("Players"):GetPlayerFromCharacter(otherPart.Parent)
			table.insert(playersTable, player)
			while task.wait() do
				telePartLabel.Text = "Players: " .. tostring(#playersTable) .. "/" .. tostring(limit)
				
        inTelePart = workspace:GetPartsInPart(telePart)
				if not table.find(inTelePart, player.Character.HumanoidRootPart) then
					break
				end
				
				-- If number of players has reached the limit, teleport
				if #playersTable == limit and not game:GetService("RunService"):IsStudio() then
					SafeTeleport(placeID, playersTable)
					break
				end
			end
			
			-- Reset after while loop dies
			
			playersTable = {}
			inTelePart = {}
			telePartLabel.Text = "Players: 0/"..tostring(limit)
			touched = false
			
		end
	end)

end

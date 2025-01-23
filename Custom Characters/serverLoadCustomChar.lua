-- Server script loads a character after receiving text from the localPlayer
-- Characters are found in ServerStorage, then cloned
-- ServerScript located at ServerScriptService

local changeCharEvent = game:GetService("ReplicatedStorage"):WaitForChild("changeCharEvent")

changeCharEvent.OnServerEvent:Connect(function(player, charName)
	local trueCharacter = game:GetService("ServerStorage"):FindFirstChild(charName)
	if trueCharacter then
		player:LoadCharacter()
		local clonedRig = trueCharacter:Clone()
		player.Character = clonedRig
		clonedRig.Parent = workspace
	end
end)

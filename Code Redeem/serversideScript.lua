-- Player insert code script. The player inserts a code in a textbox on the GUI.
-- This script features an expiry date by which point a code will become invalid.
-- The player is rewarded with coins for a valid code.

local codeFunc = game:GetService("ReplicatedStorage"):WaitForChild("codeFunction")

local codeList = {
	-- Ensure all codes are lowercase
	--[codeName] = {expiryTime, Value}
	["hectopath"] = {DateTime.fromUniversalTime(2025,2,1), 10},
	["doormat"] = {DateTime.fromUniversalTime(2025, 1, 15), 20},
	["china"] = {DateTime.fromUniversalTime(1989, 6, 3), -200},
	["bangtown"] = {DateTime.fromUniversalTime(2027,12,20), 100},
}
local currentTime = DateTime.now()

-- Server receives code after localPlayer invokes the codeFunc
codeFunc.OnServerInvoke = function(player, code)
	code = code:lower() -- In this case, I want caps to have no effect on codes
	currentTime = DateTime.now() -- Refresh time
	if codeList[code] and codeList[code][1].UnixTimestamp > currentTime.UnixTimestamp then
		local coins = player.leaderstats.Coins
		coins.Value += codeList[code][2]
		return true
	else
		return false
	end
end

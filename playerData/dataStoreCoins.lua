-- Data store handler 
-- ServerScript located at ServerScriptService

local dataStoreService = game:GetService("DataStoreService")
local coinStore = dataStoreService:GetDataStore("Currency", "Coins")

-- Fetch player data upon joining

game.Players.PlayerAdded:Connect(function(player)
	local playerCoins = player:WaitForChild("leaderstats"):WaitForChild("Coins")
	local success, coinData
	
	repeat
		success, coinData = pcall(function()
			return coinStore:GetAsync(player.UserId)
		end)
	until success
	
	if success and coinData then
		playerCoins.Value = coinData -- Existing data
	elseif not success then
		warn("Could not fetch coinData for user: "..player.Name.." - "..tostring(player.UserId))
	else
		-- Add new entry
		playerCoins.Value = 0
		local success, errorMsg = pcall(function()
			return coinStore:SetAsync(player.UserId, playerCoins)
		end)
		if not success then
			warn(errorMsg)
		end
	end
end)

-- Save player data when player leaves

game.Players.PlayerRemoving:Connect(function(player)
	local playerCoins = player:WaitForChild("leaderstats"):WaitForChild("Coins").Value
	
	local function updateCoins(coinStoreCoins)
		return playerCoins
	end
	
	repeat
		local success, errorMsg = pcall(function()
			return coinStore:UpdateAsync(player.UserId, updateCoins)
		end)
	until success
end)

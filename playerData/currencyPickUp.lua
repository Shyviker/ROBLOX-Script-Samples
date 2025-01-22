-- Currency functionality script. Can be coins, gems, diamonds, anything currency related
-- ServerScript located at ServerScriptService

local collectionService = game:GetService("CollectionService")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")

-- Currency

for _, coin in collectionService:GetTagged("currencyPart") do
	local touched = false
	local val = math.random(2,5)
	
	-- Spin the coin
	local spin = coroutine.wrap(function(part)
		runService.Heartbeat:Connect(function(dt)
			part.CFrame *= CFrame.Angles(0,math.rad(75 * dt),0)
		end)
	end)
	spin(coin)
	
	coin.Touched:Connect(function(otherPart)
		if otherPart.Parent:FindFirstChild("Humanoid") and touched == false then
			touched = true
			
			local player = game:GetService("Players"):GetPlayerFromCharacter(otherPart.Parent)
			local leaderstats = player:WaitForChild("leaderstats")
			local coins = leaderstats:WaitForChild("Coins") -- Coin stat for the player
			coins.Value += val -- Player's coin stat increases after touching the coin
			
			local tweenProperties = {
				Transparency = 1, -- Coin fades
				CFrame = coin.CFrame * CFrame.new(0,5,0) -- Coin goes up
			}
			
			local coinTween = tweenService:Create(coin, TweenInfo.new(3), tweenProperties)
			coinTween:Play()
			
			coinTween.Completed:Wait() -- Wait for tween to finish before destroying
			coin:Destroy()
		end
	end)
end

-- Simple loading screen when player joins the experience. It waits for the assets to load before allowing the player to view game content.
-- Is a LocalScript located at ReplicatedFirst

local repFirst = game:GetService("ReplicatedFirst")
local contentProvider = game:GetService("ContentProvider")
local playerService = game:GetService("Players")
local tweenService = game:GetService("TweenService")

repFirst:RemoveDefaultLoadingScreen()

local clonedGui = script:WaitForChild("ScreenGui"):Clone()
clonedGui.Parent = playerService.LocalPlayer:WaitForChild("PlayerGui")

local screen = clonedGui:WaitForChild("Frame")
local loadBar = screen:WaitForChild("loadBar"):WaitForChild("progressBar")
local loadText = screen:WaitForChild("TextLabel")

local assets = game:GetChildren()

local tween
for _, asset in pairs(assets) do
	loadText.Text = "Loading " .. asset.Name .. "..."
	contentProvider:PreloadAsync({asset})
	local progress = table.find(assets, asset) / #assets 
	local properties = {
		Size = UDim2.new(progress, 0, 1, 0)
	}
	tween = tweenService:Create(loadBar, TweenInfo.new(2.5), properties)
	tween:Play()
end

tween.Completed:Wait()

loadText.Text = "Loading complete"
task.wait(2)

-- Load GUI goes up

local endTween = tweenService:Create(screen, TweenInfo.new(5, Enum.EasingStyle.Quint), {AnchorPoint = Vector2.new(0,1)})
endTween:Play()

endTween.Completed:Wait()
clonedGui:Destroy()

-- Enable other GUI after the load screen is gone

for _, gui in playerGui do
	gui.Enabled = true
end

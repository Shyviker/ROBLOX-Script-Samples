-- Simple animation script for player movement. Only plays when player is moving on the ground.
-- LocalScript

local animation = script:WaitForChild("Animation")
local char = script.Parent
local userInput = game:GetService("UserInputService")
local hum = char:WaitForChild("Humanoid")

local animationTrack = hum.Animator:LoadAnimation(animation)

hum.Running:Connect(function()
	if hum.MoveDirection.Magnitude > 0 then
		animationTrack:Play()
		return 
	end
	animationTrack:Stop()
end)

-- Do not play the animation when the player is in the air

hum.StateChanged:Connect(function(old, new)
	if new == Enum.HumanoidStateType.Jumping or new == Enum.HumanoidStateType.Freefall then
		animationTrack:Stop()
	end	
end)

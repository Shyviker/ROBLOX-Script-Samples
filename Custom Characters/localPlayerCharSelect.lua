-- Player enters text through a textbox with the name of a character
-- This fires an event to the server for it to load the character
-- LocalScript located at StarterGui, parent is a ScreenGUI

local selectButton = script.Parent:WaitForChild("selectButton")
local textBox = script.Parent:WaitForChild("TextBox")
local changeCharEvent = game:GetService("ReplicatedStorage"):WaitForChild("changeCharEvent")

selectButton.MouseButton1Click:Connect(function()
	if not textBox.Visible then
		textBox.Visible = true -- Reveal textBox for input
	else
		textBox.Visible = false
	end
end)

textBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		changeCharEvent:FireServer(textBox.Text) -- Fire event with text of character name input by localPLayer
	end
end)

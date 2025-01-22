-- Player enters code in a text box and receives confirmation from the server on whether it is the correct code or not.

local codeFunc = game:GetService("ReplicatedStorage"):WaitForChild("codeFunction") -- Remote function

local codeBox = script.Parent:WaitForChild("TextBox") -- Box in which player enters code
local success = script.Parent:WaitForChild("successIndicator") -- Text to show player

codeBox.FocusLost:Connect(function(enterPressed)
	if enterPressed then
		local result = codeFunc:InvokeServer(codeBox.Text)
		success.Visible = true
		if result then
			success.Text = "Code redeemed!"
		else
			success.Text = "Invalid code!"
		end
		
		task.wait(2.5)
		success.Visible = false
	end
end)

--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local Colors = require(script.Parent.Parent.Parent.SectionColors)
local Button = script.Parent.Roundify
local SellTitle = script.SellTitle -- new
SellTitle.Parent = script.Parent -- new
local Purchased = false

game.ReplicatedStorage:WaitForChild("AddCar").OnClientEvent:Connect(function(carName)
	if carName == script.Parent.Name then
		Purchased = true
		SellTitle.Visible = true -- new
		Button.ImageColor3 = Colors.PurchasedColor
		Button.ImageTransparency = Colors.PurchasedTransparency
	end
end)

game.ReplicatedStorage:WaitForChild("RemoveCar").OnClientEvent:Connect(function(carName) -- new
	if carName == script.Parent.Name then
		Purchased = false
		SellTitle.Visible = false
		Button.ImageColor3 = Colors.LeaveColor
		Button.ImageTransparency = Colors.LeaveTransparency
	end
end)

script.Parent.MouseEnter:Connect(function()
	if not Purchased then
		Button.ImageColor3 = Colors.EnterColor
		Button.ImageTransparency = Colors.EnterTransparency
	end
end)

script.Parent.MouseLeave:Connect(function()
	if not Purchased then
		Button.ImageColor3 = Colors.LeaveColor
		Button.ImageTransparency = Colors.LeaveTransparency
	end
end)

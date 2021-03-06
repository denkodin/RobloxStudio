--[[                 Made by denkodin
YouTube channels:
https://www.youtube.com/c/H2MinRobloxStudio
http://www.youtube.com/c/EasyQuestinRobloxStudio

                      License to use

What is allowed?
You are allowed to use these scripts and this model in your
games without restrictions, including monetize games.

What is forbidden?
It is forbidden to sell and distribute in any way these
scripts and this model.
Also you may not distribute the model incorporated in
a derivative model (for instance, you may not made a modified
version of it and sell it or distribute it).
And you may not claim you are the creator or copyright holder
of this model or these scripts.
It is forbidden to remove this comment from the scripts.
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

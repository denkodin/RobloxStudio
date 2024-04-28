--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local PurchaseCarEvent = game.ReplicatedStorage:WaitForChild("PurchaseCar")
local BuyButton = script.Parent.BuyButton
local BackButton = script.Parent.BackButton
local Event = script.Parent.Parent.ShowPurchaseFrame
local Callback_back = nil
local Callback_buy = nil

Event.Event:Connect(function(Name, Cost, Power, CarImage)
	script.Parent.Parent.PurchaseFailedTitle.Visible = false
	script.Parent.Visible = true
	script.Parent.CarName.Text = Name
	script.Parent.Power.Text = Power .. " hp"
	script.Parent.Cost.Text = Cost
	local curCarImage = script.Parent:FindFirstChild("CarImage")
	if curCarImage then
		curCarImage:Remove()
	end
	local clonedCarImage = CarImage:Clone()
	clonedCarImage.Parent = script.Parent
	clonedCarImage.Position = UDim2.new(0, 0, 0, 0)
	clonedCarImage.Size = UDim2.new(0.8, 0, 1, 0)
	clonedCarImage.Name = "CarImage"
	if Callback_back then
		Callback_back:disconnect()
		Callback_back = nil
	end
	Callback_back = BackButton.MouseButton1Down:Connect(function()
		script.Parent.Visible = false
	end)
	if Callback_buy then
		Callback_buy:disconnect()
		Callback_buy = nil
	end
	Callback_buy = BuyButton.MouseButton1Down:Connect(function()
		local ShopCarName = CarImage.Parent.Name
		PurchaseCarEvent:FireServer(ShopCarName)
		script.Parent.Visible = false
	end)
end)

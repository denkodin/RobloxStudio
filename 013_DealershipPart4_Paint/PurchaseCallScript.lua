local PurchaseCarEvent = game.ReplicatedStorage:WaitForChild("PurchaseCar")
local PaintCarModule = require(game.ReplicatedStorage:WaitForChild("PaintCarModule"))
local GetCarColor = PaintCarModule.GetCarColor
local PaintCar = PaintCarModule.PaintCar
local BuyButton = script.Parent.BuyButton
local BackButton = script.Parent.BackButton
local PaintButton = script.Parent.PaintButton
local ColorDialog = require(game.ReplicatedStorage:WaitForChild("ColorDialogModule")).CreateDialog(script.Parent.Parent)
local Event = script.Parent.Parent.ShowPurchaseFrame
local ColorChangedEvent = script.Parent.Parent.ColorChanged
local Color = ColorDialog.Color
local Callback_paint = nil
local Callback_back = nil
local Callback_buy = nil
local Callback_color = nil

Event.Event:Connect(function(Name, Cost, Power, CarImage)
	local ChangedColor = nil
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
	local Car = clonedCarImage:FindFirstChildWhichIsA("Model")
	local StartColor = GetCarColor(Car)
	if Callback_back then
		Callback_back:disconnect()
		Callback_back = nil
	end
	Callback_back = BackButton.MouseButton1Down:Connect(function()
		script.Parent.Visible = false
		ColorDialog.Visible = false
	end)
	if Callback_buy then
		Callback_buy:disconnect()
		Callback_buy = nil
	end
	Callback_buy = BuyButton.MouseButton1Down:Connect(function()
		local ShopCarName = CarImage.Parent.Name
		PurchaseCarEvent:FireServer(ShopCarName, ChangedColor)
		script.Parent.Visible = false
		ColorDialog.Visible = false
	end)
	if Callback_paint then
		Callback_paint:disconnect()
		Callback_paint = nil
	end
	Callback_paint = PaintButton.MouseButton1Down:Connect(function()
		ColorDialog.Visible = true
		if Callback_color then
			Callback_color:disconnect()
			Callback_color = nil
		end
		Callback_color = ColorChangedEvent.Event:Connect(function(accept)
			if accept == nil then
				PaintCar(Car, Color.Value)
			elseif accept == true then
				ColorDialog.Visible = false
				if StartColor then
					local color = GetCarColor(Car)
					StartColor = color
					ChangedColor = color
				end
			elseif accept == false then
				ColorDialog.Visible = false
				if StartColor then
					PaintCar(Car, StartColor)
				end
			end
		end)
	end)
end)




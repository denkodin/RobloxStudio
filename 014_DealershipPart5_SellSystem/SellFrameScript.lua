local GetSellPriceFunc = game.ReplicatedStorage:WaitForChild("GetSellPrice")
local SellCarEvent = game.ReplicatedStorage:WaitForChild("SellCar")
local ShowSellFrameEvent = script.Parent.Parent.ShowSellFrame
local Callback_cancel = nil
local Callback_sell = nil

ShowSellFrameEvent.Event:Connect(function(Name)
	script.Parent.Visible = true
	script.Parent.Cost.Text = GetSellPriceFunc:InvokeServer(Name) .. "?"
	if Callback_cancel then
		Callback_cancel:disconnect()
		Callback_cancel = nil
	end
	Callback_cancel = script.Parent.CancelButton.MouseButton1Down:Connect(function()
		script.Parent.Visible = false
	end)
	if Callback_sell then
		Callback_sell:disconnect()
		Callback_sell = nil
	end
	Callback_sell = script.Parent.SellButton.MouseButton1Down:Connect(function()
		SellCarEvent:FireServer(Name)
		script.Parent.Visible = false
	end)
end)
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

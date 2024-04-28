--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local Event = game.ReplicatedStorage:WaitForChild("ChangeNCTitleVisible")

function IsCarExist(purchasedCars)
	local Cars = purchasedCars:GetChildren()
	return (#Cars > 0)
end

game.Players.PlayerAdded:Connect(function(player)
	Event:FireClient(player, true)
	local PurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars"):WaitForChild(player.Name)
	local CarsFound = IsCarExist(PurchasedCars)
	Event:FireClient(player, not CarsFound)
	PurchasedCars.ChildAdded:Connect(function()
		CarsFound = IsCarExist(PurchasedCars)
		Event:FireClient(player, not CarsFound)
	end)

	PurchasedCars.ChildRemoved:Connect(function()
		CarsFound = IsCarExist(PurchasedCars)
		Event:FireClient(player, not CarsFound)
	end)
end)

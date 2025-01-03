--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ServerStorage = game:GetService("ServerStorage")
local PurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

SpawnCarEvent.OnServerEvent:Connect(function(player, carName)
	local PlayerPurchasedCars = PurchasedCars:FindFirstChild(player.Name)
	if PlayerPurchasedCars then
		local Car = PlayerPurchasedCars:FindFirstChild(carName)
		local CurCar = game.Workspace:FindFirstChild(player.Name .. 'sCar')
		if CurCar then
			CurCar:Remove()
		end
		if Car then
			local clonedCar = Car:Clone()
			clonedCar.Name = player.Name .. 'sCar'
			if clonedCar:IsA("Model") then
				clonedCar:MakeJoints()
			end
			clonedCar.Parent = game.Workspace
			clonedCar:MoveTo(player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 15)
		end
	end
end)

DeleteCarEvent.OnServerEvent:Connect(function(player, Car)
	local Car = game.Workspace:FindFirstChild(player.Name .. 'sCar')
	if Car then
		Car:Remove()
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local Car = game.Workspace:FindFirstChild(player.Name .. 'sCar')
	if Car then
		Car:Remove()
	end
end)

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local Car = game.Workspace:FindFirstChild(player.Name .. 'sCar')
		if Car then
			Car:Remove()
		end
	end)
end)

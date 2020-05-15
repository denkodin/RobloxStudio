local ServerStorage = game:GetService("ServerStorage")
local PurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

SpawnCarEvent.OnServerEvent:Connect(function(player, carName)
	local PlayerPurchasedCars = PurchasedCars:FindFirstChild(player.Name)
	if PlayerPurchasedCars then
		local Car = PlayerPurchasedCars:FindFirstChild(carName)
		if Car then
			local clonedCar = Car:Clone()
			clonedCar.Name = player.Name .. 'sCar'
			clonedCar.Parent = game.Workspace
			clonedCar:MoveTo(player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 15)
		end
	end
end)

DeleteCarEvent.OnServerEvent:Connect(function(player, Car)
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
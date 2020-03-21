local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

SpawnCarEvent.OnServerEvent:Connect(function(player, carName)
	local Car = ServerStorage:FindFirstChild("Cars"):FindFirstChild(carName)
	if Car then
		local clonedCar = Car:Clone()
		clonedCar.Name = player.Name .. 'sCar'
		clonedCar.Parent = game.Workspace
		clonedCar:MoveTo(player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 15)
	end
end)

DeleteCarEvent.OnServerEvent:Connect(function(player, Car)
	if Car then
		Car:Remove()
	end
end)
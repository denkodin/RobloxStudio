--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")

SpawnCarEvent.OnServerEvent:Connect(function(player, carName)
	local Car = ServerStorage:FindFirstChild("Cars"):FindFirstChild(carName)
	local CurCar = game.Workspace:FindFirstChild(player.Name .. 'sCar')
	if CurCar then
		CurCar:Remove()
	end
	if Car then
		local clonedCar = Car:Clone()
		clonedCar.Name = player.Name .. 'sCar'
		clonedCar.Parent = game.Workspace
		clonedCar:MoveTo(player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 15)
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

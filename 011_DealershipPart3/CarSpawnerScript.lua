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

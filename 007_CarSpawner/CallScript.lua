--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")
local carName = script.Parent.Name
local SpawnCarFrame = script.Parent.Parent

script.Parent.MouseButton1Down:Connect(function()
	SpawnCarFrame.Visible = false
	local CurrentCar = game.Workspace:FindFirstChild(player.Name .. 'sCar')
	if not CurrentCar then
		SpawnCarEvent:FireServer(carName)
	else
		if player.Character.Humanoid.SeatPart ~= nil and player.Character.Humanoid.SeatPart:IsA("VehicleSeat") then
			player.Character.Humanoid.Sit = false
		end
		wait()
		DeleteCarEvent:FireServer(CurrentCar)
		SpawnCarEvent:FireServer(carName)
	end
end)

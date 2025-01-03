--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
hhttps://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local player = game.Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SpawnCarEvent = game.ReplicatedStorage:WaitForChild("SpawnCar")
local DeleteCarEvent = game.ReplicatedStorage:WaitForChild("DeleteCar")
local CarParams = game.ReplicatedStorage:WaitForChild("GetCarParams"):InvokeServer(script.Parent.Name)
local carName = script.Parent.Name
local SpawnCarFrame = script.Parent.Parent

script.Parent.CarName.Text = CarParams.Name

script.Parent.MouseButton1Down:Connect(function()
	SpawnCarFrame.Visible = false
	local CurrentCar = game.Workspace:FindFirstChild(player.Name .. "sCar")
	if not CurrentCar then
		SpawnCarEvent:FireServer(carName)
	else
		for i, v in pairs(CurrentCar:GetDescendants()) do
			if v:IsA("VehicleSeat") or v:IsA("Seat") then
				if v.Occupant and v.Occupant:IsA("Humanoid") then
					v.Occupant.Sit = false
				end
			end
		end
		wait()
		DeleteCarEvent:FireServer(CurrentCar)
		SpawnCarEvent:FireServer(carName)
	end
end)

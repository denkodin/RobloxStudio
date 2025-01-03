--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeleteCarEvent = ReplicatedStorage:WaitForChild("DeleteCar")
local player = game.Players.LocalPlayer

game.Workspace.ChildAdded:Connect(function(Added)
	if Added.Name == player.Name .. 'sCar' then
		script.Parent.Visible = true
	end
end)

script.Parent.MouseButton1Down:Connect(function()
	local Car = game.Workspace:FindFirstChild(player.Name .. 'sCar')
	if Car then
		script.Parent.Visible = false
		for i, v in pairs(Car:GetDescendants()) do
			if v:IsA("VehicleSeat") or v:IsA("Seat") then
				if v.Occupant and v.Occupant:IsA("Humanoid") then
					v.Occupant.Sit = false
				end
			end
		end
		wait()
		DeleteCarEvent:FireServer(Car)
	end
end)

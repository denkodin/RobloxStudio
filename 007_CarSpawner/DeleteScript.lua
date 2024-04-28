--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
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
		if player.Character.Humanoid.SeatPart ~= nil and player.Character.Humanoid.SeatPart:IsA("VehicleSeat") then
			player.Character.Humanoid.Sit = false
		end
		wait()
		DeleteCarEvent:FireServer(Car)
	end
end)

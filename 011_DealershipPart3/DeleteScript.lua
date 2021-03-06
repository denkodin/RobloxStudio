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

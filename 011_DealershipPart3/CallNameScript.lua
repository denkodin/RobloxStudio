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

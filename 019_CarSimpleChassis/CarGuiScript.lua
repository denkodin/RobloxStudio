--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local players = game:GetService("Players")

local car = script.Parent
local driveSeat = car.DriveSeat

local currentGui = nil

driveSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
	if currentGui then
		currentGui:Destroy()
		currentGui = nil
	end
	
	local occupant = driveSeat.Occupant
	if occupant then
		local player = players:GetPlayerFromCharacter(occupant.Parent)
		if player then
			currentGui = script.CarGui:Clone()
			currentGui.Car.Value = car
			currentGui.Parent = player.PlayerGui
		end
	end
end)

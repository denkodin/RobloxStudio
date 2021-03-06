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

local ChangeTitlesEvent = game.ReplicatedStorage:WaitForChild("ChangeTitles")
local Units = { {name = 'STUDS', coeff = 1},
				{name = 'KM', coeff = 4000},
				{name = 'MILES', coeff = 6400} }
local Unit = 3
local CashPerUnit = 250
local TimeIncrement = 0.5
local CashPerSecond = 1
local CurrencyName = "$"
local ControlCarOwner = true

local cashPerStud = 1 / Units[Unit].coeff * CashPerUnit

function getPlayerCarSeat(player)
	local character = player.Character
	if character then
		local humanoid = character:FindFirstChild("Humanoid")
		if humanoid then
			local carName = player.Name .. "sCar"
			if humanoid.SeatPart and humanoid.SeatPart:IsA("VehicleSeat") and humanoid.SeatPart.Parent then
				return (not ControlCarOwner or humanoid.SeatPart.Parent.Name == carName) and humanoid.SeatPart or nil
			end
		end
	end
	return nil
end

local driversCounters = {}

ChangeTitlesEvent.OnServerEvent:Connect(function(player)
	local counters = driversCounters[player.UserId]
	if counters ~= nil then
		counters.unit = counters.unit + 1
		if counters.unit > #Units then
			counters.unit = 1
		end
		ChangeTitlesEvent:FireClient(player, counters.duration, Units[counters.unit], counters.totalStuds, counters.cash)
	end
end)

while true do
	for i, player in pairs(game.Players:GetPlayers()) do
		local seat = getPlayerCarSeat(player)
		if seat ~= nil then
			local counters = driversCounters[player.UserId]
			if counters == nil then
				driversCounters[player.UserId] = {totalStuds = 0, cash = 0, oldCash = 0, duration = 0, unit = Unit}
				counters = driversCounters[player.UserId]
				if counters == nil then
					continue
				end
			end
			counters.duration = counters.duration + TimeIncrement
			counters.totalStuds = counters.totalStuds + (seat.Velocity.Magnitude >= 0.1 and seat.Velocity.Magnitude or 0) * TimeIncrement
			counters.cash = counters.totalStuds * cashPerStud + counters.duration * CashPerSecond
			local cashDelta = math.floor(counters.cash - counters.oldCash)
			if cashDelta >= 1 then
				player.leaderstats[CurrencyName].Value = player.leaderstats[CurrencyName].Value + cashDelta
				counters.oldCash = counters.oldCash + cashDelta
			end
			local clonedScreen = player.PlayerGui:FindFirstChild("CashDrivingScreen")
			if clonedScreen == nil then
				clonedScreen = script.CashDrivingScreen:Clone()
				if clonedScreen == nil then
					continue
				end
				clonedScreen.Parent = player.PlayerGui
			end
			ChangeTitlesEvent:FireClient(player, counters.duration, Units[counters.unit], counters.totalStuds, counters.cash)
		else
			local counters = driversCounters[player.UserId]
			if counters ~= nil then
				driversCounters[player.UserId] = nil
			end
			local clonedScreen = player.PlayerGui:FindFirstChild("CashDrivingScreen")
			if clonedScreen ~= nil then
				clonedScreen:Remove()
			end
		end
	end
	wait(TimeIncrement)
end

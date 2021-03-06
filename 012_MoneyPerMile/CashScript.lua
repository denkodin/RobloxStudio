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

local DataStoreService = game:GetService("DataStoreService")
local PlayerCash = DataStoreService:GetDataStore("PlayerCash")

function OnPlayerAdded(player)
	local stats = Instance.new("Folder", player)
	stats.Name = 'leaderstats'
	local Cash = Instance.new("NumberValue", stats)
	Cash.Name = "$"
	Cash.Value = 0
	local data
	local success, err = pcall(function()
		data = PlayerCash:GetAsync(player.UserId)
	end)
	if success then
		print("Data loaded!")
		if data then
			Cash.Value = data
		end
	else
		print("There was an error while getting data of player " .. player.Name)
		warn(err)
	end
	while true do
		wait(2)
		Cash.Value = Cash.Value + 2
	end
end

function OnPlayerRemoving(player)
	local success, err = pcall(function()
		PlayerCash:SetAsync(player.UserId, player.leaderstats:FindFirstChild("$").Value)
	end)
	if success then
		print("Data saved!")
	else
		print("There was an error while saving data of player " .. player.Name)
		warn(err)
	end
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
game.Players.PlayerRemoving:Connect(OnPlayerRemoving)

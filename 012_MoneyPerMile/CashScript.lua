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
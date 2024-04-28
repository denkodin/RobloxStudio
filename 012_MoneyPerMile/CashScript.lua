--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local DataStoreService = game:GetService("DataStoreService")
local PlayerCash = DataStoreService:GetDataStore("PlayerCash")

function OnPlayerAdded(player)
	local stats = Instance.new("Folder", player)
	stats.Name = 'leaderstats'
	local Cash = Instance.new("NumberValue", stats)
	Cash.Name = "$"
	Cash.Value = 0
	local DataLoaded = Instance.new("BoolValue", player)
	DataLoaded.Name = "CashDataLoaded"
	DataLoaded.Value = false

	local data
	local attempts = 10

	repeat
		local success, err = pcall(function()
			data = PlayerCash:GetAsync(player.UserId)
		end)
		if success then
			print("Success!")
			DataLoaded.Value = true
			break
		else
			warn("Was problem with datastore! (Attempts left ", attempts, ")")
		end
		wait(1)
		attempts = attempts - 1
	until attempts <= 0

	if not DataLoaded.Value then
		warn("Player " .. player.Name .. "'s cash data has not been loaded!")
		-- player:Kick("Couldn't load your data, try to rejoin later")
		return
	end

	if data then
		Cash.Value = data
	end
	while true do
		wait(2)
		Cash.Value = Cash.Value + 2
	end
end

function OnPlayerRemoving(player)
	if player:FindFirstChild("CashDataLoaded") and player.CashDataLoaded.Value == true then
		local attempts = 10

		repeat
			local success, err = pcall(function()
				PlayerCash:SetAsync(player.UserId, player.leaderstats:FindFirstChild("$").Value)
			end)
			if success then
				print("Success!")
				break
			else
				warn("Was problem with datastore! (Attempts left ", attempts, ")")
			end
			wait(1)
			attempts = attempts - 1
		until attempts <= 0
		if attempts <= 0 then
			warn("Player " .. player.Name .. "'s cash data has not been saved!")
		end
	end
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
game.Players.PlayerRemoving:Connect(OnPlayerRemoving)

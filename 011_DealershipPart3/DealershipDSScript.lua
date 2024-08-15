--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local DataStore = game:GetService("DataStoreService"):GetDataStore("PlayerCars")
local ShopCars = game.ServerStorage:WaitForChild("ShopCars")
local AddCarEvent = game.ReplicatedStorage:WaitForChild("AddCar")
local ServerPurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")

function OnCharacterAdded(player)
	wait(2.0)
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if PurchasedCars then
		local Cars = PurchasedCars:GetChildren()
		for i, v in pairs(Cars) do
			AddCarEvent:FireClient(player, v.Name)
		end
	end
end

function OnPlayerAdded(player)
	local CharacterAdded = 0
	local PurchasedCars = Instance.new("Folder", ServerPurchasedCars)
	PurchasedCars.Name = player.Name
	player.CharacterAdded:Wait()
	CharacterAdded = CharacterAdded + 1
	wait(2.0)

	local DataLoaded = Instance.new("BoolValue", player)
	DataLoaded.Name = "CarsDataLoaded"
	DataLoaded.Value = false

	local Data = nil
	local attempts = 10

	repeat
		local success, err = pcall(function()
			Data = DataStore:GetAsync(player.UserId)
		end)

		if success then
			print("Success!")
			DataLoaded.Value = true
			break
		else
			print("Was problem with datastore! (Attempts left ", attempts, ")")
		end
		wait(1)
		attempts = attempts - 1
	until attempts <= 0

	if not DataLoaded.Value then
		warn("Player " .. player.Name .. "'s cars data has not been loaded!")
		-- player:Kick("Couldn't load your data, try to rejoin later")
		return
	end
	if Data then
		for i, v in pairs(Data) do
			if ShopCars:FindFirstChild(v) then
				local clonedCar = ShopCars:FindFirstChild(v):Clone()
				clonedCar.Parent = PurchasedCars
				AddCarEvent:FireClient(player, v)
			end
		end
	end
	player.CharacterAdded:Connect(function()
		CharacterAdded = CharacterAdded + 1
		if CharacterAdded > 1 then
			OnCharacterAdded(player)
		end
	end)
end

function OnPlayerRemoving(player)
	local Cars = {}
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if player:FindFirstChild("CarsDataLoaded") and player.CarsDataLoaded.Value == true and PurchasedCars then
		for i, v in pairs(PurchasedCars:GetChildren()) do
			table.insert(Cars, v.Name)
		end
		local attempts = 10

		repeat
			local success, err = pcall(function()
				DataStore:SetAsync(player.UserId, Cars)
			end)

			if success then
				print("Success!")
				break
			else
				print("Was problem with datastore! (Attempts left ", attempts, ")")
			end
			wait(1)
			attempts = attempts - 1
		until attempts <= 0
		if attempts <= 0 then
			warn("Player " .. player.Name .. "'s cars data has not been saved!")
		end
		PurchasedCars:Remove()
	end
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
game.Players.PlayerRemoving:Connect(OnPlayerRemoving)

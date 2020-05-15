local DataStore = game:GetService("DataStoreService"):GetDataStore("PlayerCars")
local ShopCars = game.ServerStorage:WaitForChild("ShopCars")
local AddCarEvent = game.ReplicatedStorage:WaitForChild("AddCar")
local ServerPurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")

function OnCharacterAdded(player)
	wait(0.1)
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
	wait(0.1)
	
	local Data = nil
	local success, err = pcall(function()
		Data = DataStore:GetAsync(player.UserId)
	end)
		
	if Data then
		for i, v in pairs(Data) do
			if ShopCars:FindFirstChild(v) then
				local clonedCar = ShopCars:FindFirstChild(v):Clone()
				clonedCar.Parent = PurchasedCars
				AddCarEvent:FireClient(player, v)
			end
		end
	end
	if not success then
		print("There was an error while getting data of player " .. player.Name)
		warn(err)
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
	if PurchasedCars then
		for i, v in pairs(PurchasedCars:GetChildren()) do
			table.insert(Cars, v.Name)
		end
		local success, err = pcall(function()
			DataStore:SetAsync(player.UserId, Cars)
		end)
		if not success then
			print("There was an error while saving data of player " .. player.Name)
			warn(err)
		end
		PurchasedCars:Remove()
	end
end

game.Players.PlayerAdded:Connect(OnPlayerAdded)
game.Players.PlayerRemoving:Connect(OnPlayerRemoving)







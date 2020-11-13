local DataStore = game:GetService("DataStoreService"):GetDataStore("PlayerCars")
local ShopCars = game.ServerStorage:WaitForChild("ShopCars")
local AddCarEvent = game.ReplicatedStorage:WaitForChild("AddCar")
local ServerPurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")
local PaintCar = require(game.ReplicatedStorage:WaitForChild("PaintCarModule")).PaintCar

function OnCharacterAdded(player)
	wait(0.1)
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if PurchasedCars then
		local Cars = PurchasedCars:GetChildren()
		for i, v in pairs(Cars) do
			AddCarEvent:FireClient(player, v.Name, (v:FindFirstChild("Color") and v.Color.Value or nil))
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
			if typeof(v) ~= "table" then
				v = {car = v, color = nil}
			end
			if ShopCars:FindFirstChild(v.car) then
				local clonedCar = ShopCars:FindFirstChild(v.car):Clone()
				local color = nil
				if v.color then
					color = Color3.new(v.color.R, v.color.G, v.color.B)
					local colorvalue = Instance.new("Color3Value", clonedCar)
					colorvalue.Name = "Color"
					colorvalue.Value = color
					PaintCar(clonedCar, color)
				end
				clonedCar.Parent = PurchasedCars
				AddCarEvent:FireClient(player, v.car, color)
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
			local color = nil
			if v:FindFirstChild("Color") and v.Color:IsA("Color3Value") then
				color = {R = v.Color.Value.R, G = v.Color.Value.G, B = v.Color.Value.B}
			end
			table.insert(Cars, {car = v.Name, color = color})
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





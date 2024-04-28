--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local ShopCars = game.ServerStorage:WaitForChild("ShopCars")
local PurchaseEvent = game.ReplicatedStorage:WaitForChild("PurchaseCar")
local PurchaseFailedEvent = game.ReplicatedStorage:WaitForChild("PurchaseCarFailed")
local AddCarEvent = game.ReplicatedStorage:WaitForChild("AddCar")
local GetCarParamsFunc = game.ReplicatedStorage:WaitForChild("GetCarParams")
local ServerPurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")

function AddCar(Cost, Cash, PurchasedCars, car, player, carname)
	if Cost and Cash.Value >= Cost.Value and not PurchasedCars:FindFirstChild(carname) then
		local ClonedCar = car:Clone()
		ClonedCar.Parent = PurchasedCars
		Cash.Value = Cash.Value - Cost.Value
		AddCarEvent:FireClient(player, carname)
	elseif Cost and Cash.Value < Cost.Value and not PurchasedCars:FindFirstChild(carname) then
		PurchaseFailedEvent:FireClient(player, Color3.fromRGB(255, 0, 0), "You don't have enough money")
	elseif PurchasedCars:FindFirstChild(carname) then
		PurchaseFailedEvent:FireClient(player, Color3.fromRGB(255, 0, 0), "You already have this car")
	end
end

PurchaseEvent.OnServerEvent:Connect(function(player, carname)
	local leaderstats = player:FindFirstChild("leaderstats")
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if leaderstats and PurchasedCars then
		local car = ShopCars:FindFirstChild(carname)
		if car then
			local Cash = leaderstats:FindFirstChild("$")
			local Cost = car:FindFirstChild("Cost")
			AddCar(Cost, Cash, PurchasedCars, car, player, carname)
		end
	end
end)

function comma_value(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1 '):reverse()) .. right
end

function GetCarParams(player, carname)
	local Result = {}
	Result.Name = "No name"
	Result.Cost = "No price"
	Result.Power = "--"
	local Car = ShopCars:FindFirstChild(carname)

	if Car then
		local CarName = Car:FindFirstChild("CarName")
		if CarName then
			Result.Name = CarName.Value
		end
		local Cost = Car:FindFirstChild("Cost")
		if Cost then
			Result.Cost = Cost.Value > 0 and '$' .. comma_value(Cost.Value) or 'Free'
		end
		local Power = Car:FindFirstChild("Power")
		if Power then
			Result.Power = Power.Value
		end
	end
	return Result
end

GetCarParamsFunc.OnServerInvoke = GetCarParams

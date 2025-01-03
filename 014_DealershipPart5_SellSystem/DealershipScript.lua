--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ShopCars = game.ServerStorage:WaitForChild("ShopCars")
local PurchaseEvent = game.ReplicatedStorage:WaitForChild("PurchaseCar")
local SellCarEvent = game.ReplicatedStorage:WaitForChild("SellCar") -- new
local PurchaseFailedEvent = game.ReplicatedStorage:WaitForChild("PurchaseCarFailed")
local AddCarEvent = game.ReplicatedStorage:WaitForChild("AddCar")
local RemoveCarEvent = game.ReplicatedStorage:WaitForChild("RemoveCar") -- new
local GetCarParamsFunc = game.ReplicatedStorage:WaitForChild("GetCarParams")
local GetSellPriceFunc = game.ReplicatedStorage:WaitForChild("GetSellPrice") -- new
local ServerPurchasedCars = game.ServerStorage:WaitForChild("PurchasedCars")
local PaintCar = require(game.ReplicatedStorage:WaitForChild("PaintCarModule")).PaintCar
local SellPercent = 80 -- new

function AddCar(Cost, Cash, PurchasedCars, car, player, carname, color)
	if Cost and Cash.Value >= Cost.Value and not PurchasedCars:FindFirstChild(carname) then
		local ClonedCar = car:Clone()
		if color then
			local colorvalue = Instance.new("Color3Value", ClonedCar)
			colorvalue.Name = "Color"
			colorvalue.Value = color
			PaintCar(ClonedCar, color)
		end
		ClonedCar.Parent = PurchasedCars
		Cash.Value = Cash.Value - Cost.Value
		AddCarEvent:FireClient(player, carname, color)
	elseif Cost and Cash.Value < Cost.Value and not PurchasedCars:FindFirstChild(carname) then
		PurchaseFailedEvent:FireClient(player, Color3.fromRGB(255, 0, 0), "You don't have enough money")
	elseif PurchasedCars:FindFirstChild(carname) then
		PurchaseFailedEvent:FireClient(player, Color3.fromRGB(255, 0, 0), "You already have this car")
	end
end

PurchaseEvent.OnServerEvent:Connect(function(player, carname, color)
	local leaderstats = player:FindFirstChild("leaderstats")
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if leaderstats and PurchasedCars then
		local car = ShopCars:FindFirstChild(carname)
		if car then
			local Cash = leaderstats:FindFirstChild("$")
			local Cost = car:FindFirstChild("Cost")
			AddCar(Cost, Cash, PurchasedCars, car, player, carname, color)
		end
	end
end)

SellCarEvent.OnServerEvent:Connect(function(player, carname) -- new
	local leaderstats = player:FindFirstChild("leaderstats")
	local PurchasedCars = ServerPurchasedCars:FindFirstChild(player.Name)
	if leaderstats and PurchasedCars then
		local car = PurchasedCars:FindFirstChild(carname)
		if car then
			local Cash = leaderstats:FindFirstChild("$")
			local Cost = car:FindFirstChild("Cost")
			if Cash and Cost then
				Cash.Value = Cash.Value + Cost.Value * SellPercent / 100
				car:Remove()
				RemoveCarEvent:FireClient(player, carname)
			end
		end
	end
end)

function comma_value(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1 '):reverse()) .. right
end

function GetSellPrice(player, carname) -- new
	local ReturnCost = "No cost"
	local Car = ShopCars:FindFirstChild(carname)

	if Car then
		local Cost = Car:FindFirstChild("Cost")
		if Cost then
			local SellPrice = Cost.Value * SellPercent / 100
			ReturnCost = SellPrice > 0 and '$' .. comma_value(SellPrice) or 'Free'
		end
	end
	return ReturnCost
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
GetSellPriceFunc.OnServerInvoke = GetSellPrice -- new

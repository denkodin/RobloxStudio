--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local PaintCar = require(game.ReplicatedStorage:WaitForChild("PaintCarModule")).PaintCar
local startx, starty = 0.02, 0.015
local incx, incy = 0.32, 0.165
local countx = 3
local maxx = startx + countx * incx
local posx, posy = startx, starty
local eps = 1e-6 -- new
local cars = {} -- new

game.ReplicatedStorage:WaitForChild("ChangeNCTitleVisible").OnClientEvent:Connect(function(value)
	script.Parent.NoCars.Visible = value
end)

game.ReplicatedStorage:WaitForChild("AddCar").OnClientEvent:Connect(function(carName, carColor)
	local car = script.Parent:FindFirstChild(carName)
	if car then
		table.insert(cars, car) -- new
		car.Visible = true
		car.Position = UDim2.fromScale(posx, posy)
		posx = posx + incx
		if posx > maxx - eps then
			posx = startx
			posy = posy + incy
		end
		if carColor then
			PaintCar(car.CarImage:FindFirstChildWhichIsA("Model"), carColor)
		end
	end
end)

game.ReplicatedStorage:WaitForChild("RemoveCar").OnClientEvent:Connect(function(carName) -- new
	local car = script.Parent:FindFirstChild(carName)
	if car then
		local numpos = table.find(cars, car)
		if numpos then
			car.Visible = false
			for i = numpos + 1, #cars do
				local _posx = cars[i].Position.X.Scale - incx
				local _posy = cars[i].Position.Y.Scale
				if _posx < startx - eps then
					_posx = maxx - incx
					_posy = _posy - incy
				end
				cars[i].Position = UDim2.fromScale(_posx, _posy)
			end
			posx = posx - incx
			if posx < startx - eps then
				posx = maxx - incx
				posy = posy - incy
			end
			table.remove(cars, numpos)
		end
	end
end)

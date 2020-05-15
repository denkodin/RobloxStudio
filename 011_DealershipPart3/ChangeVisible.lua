local startx, starty = 0.02, 0.015
local incx, incy = 0.32, 0.165
local countx = 3
local maxx = startx + countx * incx
local posx, posy = startx, starty

game.ReplicatedStorage:WaitForChild("ChangeNCTitleVisible").OnClientEvent:Connect(function(value)
	script.Parent.NoCars.Visible = value
end)

game.ReplicatedStorage:WaitForChild("AddCar").OnClientEvent:Connect(function(carName)
	local car = script.Parent:FindFirstChild(carName)
	if car then
		car.Visible = true
		car.Position = UDim2.fromScale(posx, posy)
		posx = posx + incx
		if posx >= maxx then
			posx = startx
			posy = posy + incy
		end
	end
end)
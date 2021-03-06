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

local PaintCar = require(game.ReplicatedStorage:WaitForChild("PaintCarModule")).PaintCar
local startx, starty = 0.02, 0.015
local incx, incy = 0.32, 0.165
local countx = 3
local maxx = startx + countx * incx
local posx, posy = startx, starty

game.ReplicatedStorage:WaitForChild("ChangeNCTitleVisible").OnClientEvent:Connect(function(value)
	script.Parent.NoCars.Visible = value
end)

game.ReplicatedStorage:WaitForChild("AddCar").OnClientEvent:Connect(function(carName, carColor)
	local car = script.Parent:FindFirstChild(carName)
	if car then
		car.Visible = true
		car.Position = UDim2.fromScale(posx, posy)
		posx = posx + incx
		if posx >= maxx then
			posx = startx
			posy = posy + incy
		end
		if carColor then
			PaintCar(car.CarImage:FindFirstChildWhichIsA("Model"), carColor)
		end
	end
end)

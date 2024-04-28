--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local CarParams = game.ReplicatedStorage:WaitForChild("GetCarParams"):InvokeServer(script.Parent.Name)
local CarImage = script.Parent.CarImage
local ShowPurchaseFrame = script.Parent.Parent.Parent.Parent.ShowPurchaseFrame

script.Parent.CarName.Text = CarParams.Name
script.Parent.Cost.Text = CarParams.Cost

script.Parent.MouseButton1Down:Connect(function()
	ShowPurchaseFrame:Fire(CarParams.Name, CarParams.Cost, CarParams.Power, script.Parent.CarImage)
end)

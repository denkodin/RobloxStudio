--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local runService = game:GetService("RunService")

local speedo = script.Parent
local arrow = speedo.Arrow

local speedLabel = speedo.SpeedFrame.SpeedLabel

local car = speedo.Parent.Car.Value
local chassis = car:WaitForChild("Chassis")

local minAngle = -120
local maxAngle = 120

local speedConversionCoeff = 1.0

local maxSpeed = 160 / speedConversionCoeff

runService.RenderStepped:Connect(function(dt)
	local speed = chassis.AssemblyLinearVelocity.Magnitude
	
	local angle = minAngle + (maxAngle - minAngle) * math.clamp(speed / maxSpeed, 0, 1)
	
	arrow.Rotation = angle
	
	speedLabel.Text = string.format("%03d", speed * speedConversionCoeff)
end)

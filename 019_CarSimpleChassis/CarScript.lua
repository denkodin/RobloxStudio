--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local MAX_SPEED = 40
local MAX_STEER = 30

local car = script.Parent
local driveSeat = car.DriveSeat

local leftMotor = car.LeftMotor
local rightMotor = car.RightMotor

local leftServo = car.LeftServo
local rightServo = car.RightServo

driveSeat.Changed:Connect(function(property)
	if property == "ThrottleFloat" then
		leftMotor.AngularVelocity = MAX_SPEED * driveSeat.ThrottleFloat
		rightMotor.AngularVelocity = MAX_SPEED * driveSeat.ThrottleFloat
	elseif property == "SteerFloat" then
		leftServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
		rightServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
	end
end)

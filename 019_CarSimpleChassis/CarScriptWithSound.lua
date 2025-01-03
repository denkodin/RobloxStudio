--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local runService = game:GetService("RunService")

local MAX_SPEED = 60
local MAX_STEER = 30

local WHEEL_RADIUS = 2.6 / 2

local SOUND_MIN_SPEED = 0.6
local SOUND_MAX_SPEED = 1.5
local SOUND_MAX_VELOCITY = MAX_SPEED * WHEEL_RADIUS

local car = script.Parent
local chassis = car.Chassis
local sound = chassis:FindFirstChild("EngineSound")
local driveSeat = car.DriveSeat

local leftMotor = car.LeftMotor
local rightMotor = car.RightMotor

local leftServo = car.LeftServo
local rightServo = car.RightServo

if sound then
	driveSeat:GetPropertyChangedSignal("Occupant"):Connect(function()
		if driveSeat.Occupant then
			sound:Play()
		else
			sound:Stop()
		end
	end)

	runService.Heartbeat:Connect(function()
		local speed = math.abs(chassis.CFrame.LookVector:Dot(chassis.AssemblyLinearVelocity))

		sound.PlaybackSpeed = SOUND_MIN_SPEED + (SOUND_MAX_SPEED - SOUND_MIN_SPEED) * math.min(speed / SOUND_MAX_VELOCITY, 1)
	end)
end

driveSeat.Changed:Connect(function(property)
	if property == "ThrottleFloat" then
		leftMotor.AngularVelocity = MAX_SPEED * driveSeat.ThrottleFloat
		rightMotor.AngularVelocity = MAX_SPEED * driveSeat.ThrottleFloat
	elseif property == "SteerFloat" then
		leftServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
		rightServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
	end
end)

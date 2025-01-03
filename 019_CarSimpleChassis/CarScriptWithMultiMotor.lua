--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local runService = game:GetService("RunService")

local MAX_SPEED = 60
local REVERSE_MAX_SPEED = 20
local MAX_STEER = 30

local WHEEL_RADIUS = 2.6 / 2

local SOUND_MIN_SPEED = 0.6
local SOUND_MAX_SPEED = 1.5
local SOUND_MAX_VELOCITY = MAX_SPEED * WHEEL_RADIUS

local car = script.Parent
local chassis = car.Chassis
local sound = chassis:FindFirstChild("EngineSound")
local driveSeat = car.DriveSeat

local motors = {car.FLMotor, car.FRMotor, car.RLMotor, car.RRMotor}

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
		local reverse = math.min(driveSeat.ThrottleFloat, 0)
		local forward = math.max(driveSeat.ThrottleFloat, 0)

		local speed = reverse * REVERSE_MAX_SPEED + forward * MAX_SPEED
		
		for _, v in motors do
			v.AngularVelocity = speed
		end
	elseif property == "SteerFloat" then
		leftServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
		rightServo.TargetAngle = MAX_STEER * driveSeat.SteerFloat
	end
end)
--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local runService = game:GetService("RunService")

local car = script.Parent

local raycastParams = RaycastParams.new()
raycastParams.FilterType = Enum.RaycastFilterType.Exclude
raycastParams.FilterDescendantsInstances = {car}

local wheelHubFL = car:WaitForChild("WheelHub_FL")
local wheelHubFR = car:WaitForChild("WheelHub_FR")

local chassis = car:WaitForChild("Chassis")

local tireTrails = {
	{trail = wheelHubFL:WaitForChild("TireTrail"), wheel = car:WaitForChild("Wheel_FL")},
	{trail = wheelHubFR:WaitForChild("TireTrail"), wheel = car:WaitForChild("Wheel_FR")},
	
	{trail = chassis:WaitForChild("LeftTireTrail"), wheel = car:WaitForChild("Wheel_RL")},
	{trail = chassis:WaitForChild("RightTireTrail"), wheel = car:WaitForChild("Wheel_RR")},
}

local raycastDistance = 0.25
local slipThreshold = 5

runService.Heartbeat:Connect(function()
	for _, v in pairs(tireTrails) do
		local trail = v.trail
		local wheel = v.wheel
		
		local middle = (trail.Attachment0.WorldPosition + trail.Attachment1.WorldPosition) / 2
		
		local raycast = workspace:Raycast(middle, Vector3.new(0, -raycastDistance, 0), raycastParams)
		if raycast then
			local groundVel = raycast.Instance:GetVelocityAtPosition(raycast.Position)
			local tireContactVel = wheel:GetVelocityAtPosition(raycast.Position)
			
			local slip = tireContactVel - groundVel
			
			slip -= raycast.Normal * raycast.Normal:Dot(slip)
			
			trail.Enabled = slip.Magnitude > slipThreshold
		else
			trail.Enabled = false
		end
	end
end)

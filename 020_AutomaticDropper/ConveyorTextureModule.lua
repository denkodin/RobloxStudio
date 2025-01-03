--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

-- Creating a variable with a reference to RunService,
-- which can be used to run tasks every frame
local RunService = game:GetService("RunService")

local ConveyorTextureModule = {} -- Creating a table which will contain all of the module's functions

-- Creating a table in the ConveyorTextureModule table which holds references to all conveyors registered with the module
ConveyorTextureModule.conveyors = {}

-- Creating a function in the ConveyorTextureModule table to register a conveyor with the module
function ConveyorTextureModule.new(conveyor)
	table.insert(ConveyorTextureModule.conveyors, conveyor) -- Adding the conveyor to the list of registered conveyors
end

-- Creating a function in the ConveyorTextureModule table to update the texture movement on all registered conveyors
function ConveyorTextureModule.update(dt)
	for _, conveyor in pairs(ConveyorTextureModule.conveyors) do
		local conveyorTexture = conveyor:FindFirstChild("ConveyorTexture") -- Finding the texture in the conveyor
		if not conveyorTexture then
			continue -- Skipping this conveyor if it doesn't have a ConveyorTexture in it
		end
		
		local direction = conveyor:GetAttribute("Direction") -- Getting the "Direction" attribute from the conveyor
		if not direction or typeof(direction) ~= "Vector3" then
			continue -- Skipping this conveyor if the direction is missing or isn't a Vector3
		end
		
		local speed = conveyor:GetAttribute("Speed") -- Getting the "Speed" attribute from the conveyor
		if not speed or typeof(speed) ~= "number" then
			continue -- Skipping this conveyor if the speed is missing or isn't a number
		end
		
		local directionMagnitude = direction.Magnitude -- Getting the magnitude (length) of the direction vector
		if directionMagnitude <= 0 then
			continue -- Skipping this conveyor if the direction vector has zero magnitude
		end
		
		direction /= directionMagnitude -- Normalizing the direction vector to a unit vector
		
		-- Updating the texture offset to create a scrolling effect
		conveyorTexture.OffsetStudsU += direction.X * speed * dt -- Updating U offset based on the X component of the direction
		conveyorTexture.OffsetStudsV += direction.Z * speed * dt -- Updating V offset based on the Z component of the direction
	end
end

-- Connecting the update function to the Stepped event of RunService to run every frame
RunService.Stepped:Connect(function(_, dt)
	ConveyorTextureModule.update(dt) -- Calling the update function and sending the time delta between frames
end)

return ConveyorTextureModule -- Returning the ConveyorTextureModule table to make its functions accessible to other scripts

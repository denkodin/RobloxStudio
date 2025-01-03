--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ConveyorModule = {} -- Creating a table which will contain all of the module's functions

-- Creating a function in the ConveyorModule table which updates the
-- conveyor movement velocity based on its rotation and attributes
function ConveyorModule.updateConveyorVelocity(conveyor)
	local direction = conveyor:GetAttribute("Direction") -- Getting the "Direction" attribute from the conveyor
	if not direction or typeof(direction) ~= "Vector3" then
		return -- Exiting the function if the direction is missing or isn't a Vector3
	end
	
	local speed = conveyor:GetAttribute("Speed") -- Getting the "Speed" attribute from the conveyor
	if not speed or typeof(speed) ~= "number" then
		return -- Exiting the function if the speed is missing or isn't a number
	end
	
	local directionMagnitude = direction.Magnitude -- Getting the magnitude (length) of the direction vector
	if directionMagnitude > 0 then
		direction /= directionMagnitude -- Normalizing the direction vector to a unit vector if it's magnitude is greater than 0
	end
	
	-- Calculating and applying the conveyor's linear velocity in world space based on direction and speed
	conveyor.AssemblyLinearVelocity = conveyor.CFrame:VectorToWorldSpace(direction) * speed
end

-- Creating a function in the ConveyorModule table to initialize a specified conveyor's behavior
function ConveyorModule.new(conveyor)
	-- Listening for changes to the "Direction" attribute and updating the conveyor's movement velocity when it changes
	conveyor:GetAttributeChangedSignal("Direction"):Connect(function()
		ConveyorModule.updateConveyorVelocity(conveyor)
	end)
	
	-- Listening for changes to the "Speed" attribute and updating the conveyor's movement velocity when it changes
	conveyor:GetAttributeChangedSignal("Speed"):Connect(function()
		ConveyorModule.updateConveyorVelocity(conveyor)
	end)
	
	-- Listening for changes to the "Orientation" property and updating the conveyor's movement velocity when it changes
	conveyor:GetPropertyChangedSignal("Orientation"):Connect(function()
		ConveyorModule.updateConveyorVelocity(conveyor)
	end)
	
	-- Performing an initial velocity update to set the conveyor in motion
	ConveyorModule.updateConveyorVelocity(conveyor)
end

return ConveyorModule -- Returning the ConveyorModule table to make its functions accessible to other scripts

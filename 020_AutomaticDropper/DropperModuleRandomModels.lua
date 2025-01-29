-- Creating a variable with a reference to the Debris service,
-- which handles automatic cleanup of objects after a specified amount of time
local Debris = game:GetService("Debris")

-- Creating a table which will contain all of the module's functions
local DropperModule = {}

-- Creating a variable with a reference to the folder where drops will be stored in the workspace
local dropsFolder = workspace.DropsFolder

-- Creating a function in the DropperModule table which will create a drop from a specified dropper
function DropperModule.drop(dropper, dropObject)
	-- Finding a part called DropPart inside the dropper, at which position the drop will appear
	local dropPart = dropper:FindFirstChild("DropPart")
	if not dropPart then
		return -- Exiting the function if the DropPart is missing
	end
	
	-- Finding an ObjectValue called DropObject inside the dropper,
	-- which sets the object that will be dropped
	local dropObject = dropper:FindFirstChild("DropObject")
	if not dropObject or not dropObject:IsA("ObjectValue") or dropObject.Value == nil then
		-- Exiting the function if DropObject is missing,
		-- is not an ObjectValue, or does not have a valid value
		return
	end
	
	dropObject = dropObject.Value
	
	if dropObject:IsA("Folder") then
		local children = dropObject:GetChildren()
		
		local index = math.random(1, #children)
		
		dropObject = children[index]
	end
	
	local newDrop = dropObject:Clone() -- Cloning the object to be dropped
	newDrop:PivotTo(dropPart:GetPivot()) -- Positioning the new drop at DropPart's location
	newDrop.Parent = dropsFolder -- Setting the parent of the new drop to the drops folder
	
	-- Scheduling the drop for automatic cleanup after a specified lifetime
	Debris:AddItem(newDrop, dropper:GetAttribute("DropLifetime"))
end

-- Creating a function in the DropperModule table to initialize a specified dropper's behavior
function DropperModule.new(dropper)
	while true do
		if dropper:GetAttribute("Activated") == true then -- Checking if the dropper is activated
			DropperModule.drop(dropper) -- Calling the drop function to create a drop

			-- Waiting for the specified cooldown time before creating the next drop
			task.wait(dropper:GetAttribute("DropCooldown"))
		else
			-- Waiting for the Activated attribute to get changed
			dropper:GetAttributeChangedSignal("Activated"):Wait()
		end
	end
end

return DropperModule -- Returning the DropperModule table to make its functions accessible to other scripts

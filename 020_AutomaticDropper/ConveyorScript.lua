--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

-- Creating a variable with a reference to ServerScriptService, where server scripts are stored
local ServerScriptService = game:GetService("ServerScriptService")
-- Loading the ConveyorModule from ServerScriptService
local ConveyorModule = require(ServerScriptService.ConveyorModule)

-- Initializing the conveyor by calling the "new" function from the ConveyorModule
-- The parent of this script (typically the conveyor part) is passed as an argument
ConveyorModule.new(script.Parent)
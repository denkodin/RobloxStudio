--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

-- Creating a variable with a reference to the ServerScriptService, where server scripts are stored
local ServerScriptService = game:GetService("ServerScriptService")
-- Loading the DropperModule from ServerScriptService
local DropperModule = require(ServerScriptService.DropperModule)

-- Initializing the dropper by calling the "new" function from the DropperModule
-- The parent of this script (typically the dropper model) is passed as an argument
DropperModule.new(script.Parent)
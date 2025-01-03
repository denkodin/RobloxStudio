--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

-- Creating a variable with a reference to ReplicatedStorage, where resources that are replicated to the client are stored
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Loading the ConveyorTextureModule from ReplicatedStorage
local ConveyorTextureModule = require(ReplicatedStorage.ConveyorTextureModule)

-- Registering the conveyor with the ConveyorTextureModule
-- The parent of this script (typically the conveyor model) is passed as an argument
ConveyorTextureModule.new(script.Parent)
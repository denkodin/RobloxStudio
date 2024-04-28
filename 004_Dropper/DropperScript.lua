--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local Drop = script.Parent.Drop

function MakeBlock()
	local Block = Instance.new("Part", game.Workspace)
	Block.CFrame = Drop.CFrame
	Block.Size = Vector3.new(2, 1, 2)
	Block.Material = Enum.Material.Concrete
	Block.BrickColor = BrickColor.new("White")
	game.Debris:AddItem(Block, 5)
end

while true do
	wait(1)
	MakeBlock()
end

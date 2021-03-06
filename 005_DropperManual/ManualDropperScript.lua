--[[                 Made by denkodin
YouTube channels:
https://www.youtube.com/c/H2MinRobloxStudio
http://www.youtube.com/c/EasyQuestinRobloxStudio

                      License to use

What is allowed?
You are allowed to use these scripts and this model in your
games without restrictions, including monetize games.

What is forbidden?
It is forbidden to sell and distribute in any way these
scripts and this model.
Also you may not distribute the model incorporated in
a derivative model (for instance, you may not made a modified
version of it and sell it or distribute it).
And you may not claim you are the creator or copyright holder
of this model or these scripts.
It is forbidden to remove this comment from the scripts.
]]

local Button = script.Parent.Button
local Drop = script.Parent.Drop
local Ready = true

function MakeBlock()
	if Ready then
		Ready = false
		local Block = Instance.new("Part", game.Workspace)
		Block.CFrame = Drop.CFrame
		Block.Size = Vector3.new(2, 1, 2)
		Block.Material = Enum.Material.Fabric
		Block.BrickColor = BrickColor.new("Medium stone grey")
		game.Debris:AddItem(Block, 5)
		wait(0.1)
		Ready = true
	end
end
Button.ClickDetector.MouseClick:Connect(MakeBlock)

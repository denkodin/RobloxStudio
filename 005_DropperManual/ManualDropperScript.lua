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
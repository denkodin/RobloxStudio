--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local Template = script.Parent.DropPart:GetChildren()[1]:Clone()
local Button = script.Parent.Button
local Drop = script.Parent.Drop
local Ready = true

script.Parent.DropPart:GetChildren()[1]:Remove()

function MakeBlock()
	if Ready then
		Ready = false
		local Block = Template:Clone()
		Block.Parent = game.Workspace
		Block.CFrame = Drop.CFrame
		game.Debris:AddItem(Block, 15)
		wait(0.1)
		Ready = true
	end
end
Button.ClickDetector.MouseClick:Connect(MakeBlock)

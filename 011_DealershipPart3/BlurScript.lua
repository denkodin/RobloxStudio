local CarSpawner = script.Parent.Parent:WaitForChild("CarSpawnerScreen")
local Sections = script.Parent.Sections:GetChildren()
local StarterGui = game.StarterGui
local hide_gui = {Enum.CoreGuiType.Chat, Enum.CoreGuiType.Backpack, Enum.CoreGuiType.EmotesMenu, Enum.CoreGuiType.PlayerList}
local visibles = {}
local Blur = nil

for i, g in pairs(hide_gui) do
	visibles[g] = StarterGui:GetCoreGuiEnabled(g)
end

function Check()
	if script.Parent.Enabled == false then
		if Blur then
			Blur:Remove()
			Blur = nil
		end
		for i, g in pairs(hide_gui) do
			StarterGui:SetCoreGuiEnabled(g, visibles[g])
		end
		CarSpawner.Enabled = true
	else
		if not Blur then
			Blur = script.Blur:Clone()
			Blur.Parent = game.Workspace.CurrentCamera
		end
		for i, g in pairs(hide_gui) do
			visibles[g] = StarterGui:GetCoreGuiEnabled(g)
			StarterGui:SetCoreGuiEnabled(g, false)
		end
		for i, v in pairs(Sections) do
			if v:IsA("Frame") or v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end
		script.Parent.DealershipTitle.Text = "Dealership"
		script.Parent.PurchaseFrame.Visible = false
		script.Parent.PurchaseFailedTitle.Visible = false
		CarSpawner.Enabled = false
	end
end

Check()
script.Parent.Changed:Connect(Check)
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
		script.Parent.ColorDialog.Visible = false
		script.Parent.SellFrame.Visible = false -- new
		script.Parent.PurchaseFailedTitle.Visible = false
		CarSpawner.Enabled = false
	end
end

Check()
script.Parent:GetPropertyChangedSignal("Enabled"):Connect(Check)

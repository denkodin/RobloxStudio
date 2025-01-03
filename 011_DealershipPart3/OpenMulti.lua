--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local CloseButton = script.Parent.Close
local Detector = nil

for i, v in pairs(game.Workspace:GetChildren()) do
	if v.Name == "Dealership" and v:FindFirstChild("Detector") then
		v.Detector.Touched:Connect(function(hit)
			if game.Players:GetPlayerFromCharacter(hit.Parent) == game.Players.LocalPlayer then
				script.Parent.Enabled = true
				Detector = v.Detector
			end
		end)
	end
end

CloseButton.MouseButton1Down:Connect(function()
	script.Parent.Enabled = false
end)

script.Parent.Enabled = false

script.Parent:GetPropertyChangedSignal("Enabled"):Connect(function()
	while script.Parent.Enabled do
		wait(0.1)
		if game.Players.LocalPlayer.Character and Detector ~= nil then
			local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			local mag = (HumanoidRootPart.Position - Detector.Position).Magnitude
			local CloseDistance = math.max(Detector.Size.X, Detector.Size.Z)
			if mag >= CloseDistance + math.max(HumanoidRootPart.Size.X, HumanoidRootPart.Size.Z) and script.Parent.Enabled == true then
				script.Parent.Enabled = false
			end
		end
	end
end)

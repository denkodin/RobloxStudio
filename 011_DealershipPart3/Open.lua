local Detector = game.Workspace.Dealership.Detector
local CloseDistance = math.max(Detector.Size.X, Detector.Size.Z)
local CloseButton = script.Parent.Close

Detector.Touched:Connect(function(hit)
	if game.Players:GetPlayerFromCharacter(hit.Parent) == game.Players.LocalPlayer then
		script.Parent.Enabled = true
	end
end)

CloseButton.MouseButton1Down:Connect(function()
	script.Parent.Enabled = false
end)

while true do
	wait()
	if game.Players.LocalPlayer.Character then
		local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		local mag = (HumanoidRootPart.Position-Detector.Position).Magnitude
		if mag >= CloseDistance + math.max(HumanoidRootPart.Size.X, HumanoidRootPart.Size.Z) and script.Parent.Enabled == true then
			script.Parent.Enabled = false
		end
	end
end
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

while true do
	wait()
	if game.Players.LocalPlayer.Character and Detector ~= nil then
		local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
		local CloseDistance = math.max(Detector.Size.X, Detector.Size.Z)
		local mag = (HumanoidRootPart.Position - Detector.Position).Magnitude
		if mag >= CloseDistance + math.max(HumanoidRootPart.Size.X, HumanoidRootPart.Size.Z) and script.Parent.Enabled == true then
			script.Parent.Enabled = false
		end
	end
end
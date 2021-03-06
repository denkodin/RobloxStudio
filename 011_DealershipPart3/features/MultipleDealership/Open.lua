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

local Detector = script:WaitForChild("Dealership").Value:WaitForChild("Detector")
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

script.Parent:GetPropertyChangedSignal("Enabled"):Connect(function()
	while script.Parent.Enabled do
		wait(0.1)
		if game.Players.LocalPlayer.Character then
			local HumanoidRootPart = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
			local mag = (HumanoidRootPart.Position-Detector.Position).Magnitude
			if mag >= CloseDistance + math.max(HumanoidRootPart.Size.X, HumanoidRootPart.Size.Z) and script.Parent.Enabled == true then
				script.Parent.Enabled = false
			end
		end
	end
end)

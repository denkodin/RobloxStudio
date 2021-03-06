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

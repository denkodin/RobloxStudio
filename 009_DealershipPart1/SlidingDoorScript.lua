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

local OpenTime = 3
local Opened = false
local Detector = script.Parent.Detector
local LeftDoor = script.Parent.LeftDoor
local RightDoor = script.Parent.RightDoor

function OnTouched(hit)
	local humanoid = hit.Parent:FindFirstChild("Humanoid")
	if humanoid then
		if Opened == false then
			Opened = true
			for i = 1, 40 do
				RightDoor:SetPrimaryPartCFrame(RightDoor.PrimaryPart.CFrame + RightDoor.PrimaryPart.CFrame.LookVector*0.1)
				LeftDoor:SetPrimaryPartCFrame(LeftDoor.PrimaryPart.CFrame - LeftDoor.PrimaryPart.CFrame.LookVector*0.1)
				wait()
			end
			wait(OpenTime)
			for i = 1, 40 do
				RightDoor:SetPrimaryPartCFrame(RightDoor.PrimaryPart.CFrame - RightDoor.PrimaryPart.CFrame.LookVector*0.1)
				LeftDoor:SetPrimaryPartCFrame(LeftDoor.PrimaryPart.CFrame + LeftDoor.PrimaryPart.CFrame.LookVector*0.1)
				wait()
			end
			Opened = false
		end
	end
end

Detector.Touched:Connect(OnTouched)

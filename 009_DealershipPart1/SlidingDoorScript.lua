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
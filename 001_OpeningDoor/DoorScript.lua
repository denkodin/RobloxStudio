--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local Hinge = script.Parent.PrimaryPart
local opened = false

function OpenDoor()
	if opened == false then
		opened = true
		for i = 1, 21 do
			script.Parent:SetPrimaryPartCFrame(Hinge.CFrame*CFrame.Angles(0, math.rad(5), 0))
			wait()
		end
	else
		opened = false
		for i = 1, 21 do
			script.Parent:SetPrimaryPartCFrame(Hinge.CFrame*CFrame.Angles(0, math.rad(-5), 0))
			wait()
		end
	end
end

script.Parent.Handle1.ClickDetector.MouseClick:Connect(OpenDoor)
script.Parent.Handle2.ClickDetector.MouseClick:Connect(OpenDoor)

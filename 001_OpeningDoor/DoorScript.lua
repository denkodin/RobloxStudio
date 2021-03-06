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

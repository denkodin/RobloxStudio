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

local Sections = script.Parent.Parent.Sections
local Section = Sections:FindFirstChild(script.Parent.Name)
local Colors = require(script.Parent.Parent.MenuColors)
local Button = script.Parent.Roundify

function Check(Paint)
	if Section then
		if Paint then
			if Section.Visible then
				Button.ImageColor3 = Colors.SelectedColor
				Button.ImageTransparency = Colors.SelectedTransparency
			else
				Button.ImageColor3 = Colors.LeaveColor
				Button.ImageTransparency = Colors.LeaveTransparency
			end
		end
		return Section.Visible
	end
end

script.Parent.MouseEnter:Connect(function()
	if not Check(false) then
		Button.ImageColor3 = Colors.EnterColor
		Button.ImageTransparency = Colors.EnterTransparency
	end
end)

script.Parent.MouseLeave:Connect(function()
	if not Check(false) then
		Button.ImageColor3 = Colors.LeaveColor
		Button.ImageTransparency = Colors.LeaveTransparency
	end
end)

Section.Changed:Connect(function()
	Check(true)
end)

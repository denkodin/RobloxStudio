--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
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

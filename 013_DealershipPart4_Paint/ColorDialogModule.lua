--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ColorDialog = {}

function ColorDialog.CreateDialog(Parent, Position, Size)
	local clone = script.ColorDialog:Clone()
	if Position then
		clone.Position = Position
	end
	if Size then
		clone.Size = Size
	end
	clone.Palette.PaletteScript.Disabled = false
	clone.Parent = Parent
	return clone
end

return ColorDialog

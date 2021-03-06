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

--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local ExtraObjectTypes = {"Frame", "ScrollingFrame", "TextButton", "TextBox", "TextLabel", "ViewportFrame", "ImageLabel", "ImageButton"}

for i, v in pairs(script.Parent:GetDescendants()) do
	if v:IsA("ViewportFrame") then
		for j, f in pairs(v:GetDescendants()) do
			if table.find(ExtraObjectTypes, f.ClassName) then
				f.Visible = false
			end
		end
	end
end

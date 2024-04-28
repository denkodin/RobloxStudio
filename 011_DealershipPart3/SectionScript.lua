--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

local Sections = script.Parent.Parent.Sections:GetChildren()
local SectionName = script.Parent.Name

script.Parent.MouseButton1Down:Connect(function()
	for i, v in pairs(Sections) do
		if v:IsA("Frame") or v:IsA("ScrollingFrame") then
			if v.Name ~= SectionName then
				v.Visible = false
			else
				v.Visible = true
			end
		end
	end

	script.Parent.Parent.DealershipTitle.Text = "Dealership (" .. SectionName .. ")"
end)

--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local frame = script.Parent
local template = frame.Template:Clone()
local okbutton = frame.Parent.OKButton
local cancelbutton = frame.Parent.CancelButton
local color = frame.Parent.Color
local colorchangedevent = frame.Parent.Parent.ColorChanged

frame.Template:Remove()

function OnColorButtonClick(h, s, v)
	okbutton.BackgroundColor3 = Color3.fromHSV(h, s, v)
	if (s == 0 and v < 0.5) or (s > 0 and v < 1) or (h > 0.6 and h < 0.8 and v == 1 and s >= 0.8) then
		okbutton.TextColor3 = Color3.new(1, 1, 1)
	else
		okbutton.TextColor3 = Color3.new(0, 0, 0)
	end
	color.Value = Color3.fromHSV(h, s, v)
	colorchangedevent:Fire(nil)
end

okbutton.MouseButton1Down:Connect(function()
	colorchangedevent:Fire(true)
end)

cancelbutton.MouseButton1Down:Connect(function()
	colorchangedevent:Fire(false)
end)

for x = 0, 12 do
	for y = 0, 8 do
		local color_button = template:Clone()
		color_button.Name = "ColorButton[" .. x .. "," .. y .. "]"
		color_button.Parent = frame
		color_button.Position = UDim2.new(x * color_button.Size.X.Scale + x * 0.004, 0, y * color_button.Size.Y.Scale
			+ y * 0.004, 0)
		local h, s, v = 0, 0, 0
		if x < 12 then
			h = x * 30 / 360
			s = y < 4 and 1 or (1 - (y - 4) * 20 / 100)
			v = y > 4 and 1 or ((y + 1) * 20 / 100)
		else
			h, s = 0, 0
			v = y * 12.5 / 100
		end
		color_button.Color.BackgroundColor3 = Color3.fromHSV(h, s, v)

		color_button.MouseButton1Down:Connect(function()
			OnColorButtonClick(h, s, v)
		end)
	end
end

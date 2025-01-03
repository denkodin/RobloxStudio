--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local PaintCarModule = {}
local PaintPartNames = {"Paint", "PAINT", "paint", "Color", "COLOR", "color"}
local PaintValueName = "Paint"

function PaintCarModule.GetCarColor(car)
	if car then
		for _, v in pairs(car:GetDescendants()) do
			if (v:IsA("BasePart") or v:IsA("UnionOperation") or v:IsA("MeshPart")) and (
				table.find(PaintPartNames, v.Name) or v:FindFirstChild(PaintValueName)) then
				return v.Color
			end
		end
	end
	return nil
end

function PaintCarModule.PaintCar(car, color)
	for _, v in pairs(car:GetDescendants()) do
		if (v:IsA("BasePart") or v:IsA("UnionOperation") or v:IsA("MeshPart")) and (
			table.find(PaintPartNames, v.Name) or v:FindFirstChild(PaintValueName)) then
			v.Color = color
		end
	end
end

return PaintCarModule

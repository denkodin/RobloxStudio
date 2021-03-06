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

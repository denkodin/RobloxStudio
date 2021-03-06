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

local player = game.Players.LocalPlayer

function comma_value(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1 '):reverse()) .. right
end

local leaderstats = player:WaitForChild("leaderstats")
local Cash = leaderstats:WaitForChild("$")

if not Cash:IsA("NumberValue") and not Cash:IsA("IntValue") then
	return
end

function UpdateCashTitle(value)
	script.Parent.Text = "$" .. comma_value(value)
end

UpdateCashTitle(Cash.Value)

Cash.Changed:Connect(function()
	UpdateCashTitle(Cash.Value)
end)

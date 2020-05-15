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
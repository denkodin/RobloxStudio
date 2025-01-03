--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/@H2MBlox
https://www.youtube.com/@EasyQuestinRobloxStudio
]]

local ChangeTitlesEvent = game.ReplicatedStorage:WaitForChild("ChangeTitles")
script.Parent:TweenPosition(UDim2.new(0.635, 0, 0.005, 0))

function comma_value(n)
	local left, num, right = string.match(n, '^([^%d]*%d)(%d*)(.-)$')
	return left .. (num:reverse():gsub('(%d%d%d)', '%1 '):reverse()) .. right
end

function toHMS(seconds)
	local h = math.floor(seconds / 3600)
	local m = math.floor(seconds / 60) % 60
	local s = seconds % 60

	return string.format("%02d:%02d:%02d", h, m, s)
end

ChangeTitlesEvent.OnClientEvent:Connect(function(Time, Unit, Distance, Cash)
	local scale = Unit.coeff
	script.Parent.CashLabel.CashValue.Text = comma_value(math.floor(Cash))
	script.Parent.MileageLabel.MileageName.Text = Unit.name
	script.Parent.MileageLabel.MileageValue.Text = math.floor(Distance / scale * 100) / 100
	script.Parent.TimeLabel.TimeValue.Text = toHMS(Time)
end)

script.Parent.MileageLabel.ChangeUnitButton.MouseButton1Down:Connect(function()
	ChangeTitlesEvent:FireServer()
end)

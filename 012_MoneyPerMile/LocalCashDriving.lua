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

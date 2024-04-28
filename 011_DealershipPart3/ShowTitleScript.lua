--[[            Made by denkodin
https://www.roblox.com/users/342156146/profile
https://www.youtube.com/c/H2MinRobloxStudio
https://www.youtube.com/c/EasyQuestinRobloxStudio
]]

game.ReplicatedStorage:WaitForChild("PurchaseCarFailed").OnClientEvent:Connect(function(Color, Title)
	script.Parent.Text = Title
	script.Parent.TextColor3 = Color
	script.Parent.Visible = true
end)

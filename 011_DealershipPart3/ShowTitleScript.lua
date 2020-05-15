game.ReplicatedStorage:WaitForChild("PurchaseCarFailed").OnClientEvent:Connect(function(Color, Title)
	script.Parent.Text = Title
	script.Parent.TextColor3 = Color
	script.Parent.Visible = true
end)
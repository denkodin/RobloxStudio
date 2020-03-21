local CarSpawnerFrame = script.Parent.Parent.Frame

script.Parent.MouseButton1Down:Connect(function()
	CarSpawnerFrame.Visible = not CarSpawnerFrame.Visible
end)
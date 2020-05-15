local CarSpawnerFrame = script.Parent.Parent.CarSpawnerFrame

script.Parent.MouseButton1Down:Connect(function()
	CarSpawnerFrame.Visible = not CarSpawnerFrame.Visible
end)
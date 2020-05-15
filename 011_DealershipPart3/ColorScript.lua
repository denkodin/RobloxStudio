script.Parent.MouseEnter:Connect(function()
	script.Parent.ImageTransparency = 0
	script.Parent.ImageColor3 = Color3.fromRGB(200,200,200)
end)
script.Parent.MouseLeave:Connect(function()
	script.Parent.ImageTransparency = 0.5
	script.Parent.ImageColor3 = Color3.fromRGB(255,255,255)
end)
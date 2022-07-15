-- Settings

local CursorScaling = true
local MouseIconSize = 128 * 20

local ScanDistance = 32

-- Code

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ScanDoorRE = ReplicatedStorage:WaitForChild("ScanDoorRE")
local ScanDoorRF = ReplicatedStorage:WaitForChild("ScanDoorRF")

local UserInputService = game:GetService("UserInputService")

local RunService = game:GetService("RunService")

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local PlayerGui = Player:WaitForChild("PlayerGui")
local ScanDoorGui = PlayerGui:WaitForChild("ScanDoorGui")

local MouseIcon = ScanDoorGui:WaitForChild("MouseIcon")

local NewRaycastParams = RaycastParams.new()
NewRaycastParams.FilterType = Enum.RaycastFilterType.Blacklist

local Camera = workspace.CurrentCamera

local function MouseRaycast()
	local MouseLocation = UserInputService:GetMouseLocation()
	local MouseRay = Camera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y)
	
	local Origin = MouseRay.Origin
	local Direction = MouseRay.Direction * 1000
	
	NewRaycastParams.FilterDescendantsInstances = {Player.Character}
	
	return workspace:Raycast(Origin, Direction, NewRaycastParams)
end

local Down = false

local LastScanner = nil

UserInputService.InputBegan:Connect(function(InputObject)
	if InputObject.UserInputType == Enum.UserInputType.MouseButton1 or InputObject.UserInputType == Enum.UserInputType.Touch then
		Down = true
	end
end)

UserInputService.InputEnded:Connect(function(InputObject)
	if InputObject.UserInputType == Enum.UserInputType.MouseButton1 or InputObject.UserInputType == Enum.UserInputType.Touch then
		Down = false
	end
end)

for _, OpenedDoor in pairs(ScanDoorRF:InvokeServer({Event = "GetOpenedDoors"})) do
	local DoorModel = OpenedDoor:WaitForChild("Door")
	
	local OriginValue = DoorModel:WaitForChild("OriginValue")
	
	DoorModel:SetPrimaryPartCFrame(OriginValue.Value * CFrame.new(0, OpenedDoor:GetAttribute("OpenHeight"), 0))
end

ScanDoorRE.OnClientEvent:Connect(function(Data)
	local Event = Data.Event
	if Event == "OpenDoor" then
		local ScanDoor = Data.Door
		
		local Door = ScanDoor:WaitForChild("Door")
		local DoorMain = Door:WaitForChild("Main")
		
		local DoorOrigin = Door:WaitForChild("OriginValue")
		
		local OpenSound = DoorMain:FindFirstChild("OpenSound")
		if OpenSound then
			OpenSound:Play()
		end
		
		local CloseSound = DoorMain:FindFirstChild("CloseSound")
		if CloseSound then
			CloseSound:Stop()
		end
		
		local Progress = DoorOrigin.Value:ToObjectSpace(Door:GetPrimaryPartCFrame()).Y / ScanDoor:GetAttribute("OpenHeight")
		
		local Opening = true
		
		Door:SetAttribute("Opening", true)
		
		local Connection = Door:GetAttributeChangedSignal("Opening"):Connect(function()
			if Door:GetAttribute("Opening") == false then
				Opening = false
			end
		end)
		
		while Progress < 1 and Opening do
			Progress = math.clamp(Progress + RunService.Heartbeat:Wait() / ScanDoor:GetAttribute("OpenTime"), 0, 1)
			
			if Opening then
				Door:SetPrimaryPartCFrame(DoorOrigin.Value * CFrame.new(0, ScanDoor:GetAttribute("OpenHeight") * Progress, 0))
			end
		end
		
		if Connection then
			Connection:Disconnect()
			Connection = nil
		end
	elseif Event == "CloseDoor" then
		local ScanDoor = Data.Door
		
		local Door = ScanDoor:WaitForChild("Door")
		local DoorMain = Door:WaitForChild("Main")
		
		local DoorOrigin = Door:WaitForChild("OriginValue")
		
		local OpenSound = DoorMain:FindFirstChild("OpenSound")
		if OpenSound then
			OpenSound:Stop()
		end
		
		local CloseSound = DoorMain:FindFirstChild("CloseSound")
		if CloseSound then
			CloseSound:Play()
		end
		
		local Progress = DoorOrigin.Value:ToObjectSpace(Door:GetPrimaryPartCFrame()).Y / ScanDoor:GetAttribute("OpenHeight")
		
		local Closing = true
		
		Door:SetAttribute("Opening", false)
		
		local Connection = Door:GetAttributeChangedSignal("Opening"):Connect(function()
			if Door:GetAttribute("Opening") == true then
				Closing = false
			end
		end)
		
		while Progress > 0 and Closing do
			Progress = math.clamp(Progress - RunService.Heartbeat:Wait() / ScanDoor:GetAttribute("CloseTime"), 0, 1)
			
			if Closing then
				Door:SetPrimaryPartCFrame(DoorOrigin.Value * CFrame.new(0, ScanDoor:GetAttribute("OpenHeight") * Progress, 0))
			end
		end
		
		if Connection then
			Connection:Disconnect()
			Connection = nil
		end
	end
end)

RunService.RenderStepped:Connect(function(DeltaTime)
	local Raycast = MouseRaycast()
	local Scanner = nil
	local ScanDoor = nil
	local OnScanner = false
	
	local RootPart = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
	
	if Raycast and Raycast.Instance.Name == "Scanner" and RootPart and (Raycast.Position - RootPart.Position).Magnitude <= ScanDistance then
		local ScannerModel = Raycast.Instance.Parent
		if ScannerModel then
			local ScanDoorA = ScannerModel.Parent
			
			if ScanDoorA and ScanDoorA:GetAttribute("ScanDoor") == true then
				Scanner = ScannerModel
				ScanDoor = ScanDoorA
				OnScanner = true
			end
		end
	end
	
	MouseIcon.Visible = OnScanner
	UserInputService.MouseIconEnabled = not OnScanner
	
	if OnScanner then
		local MouseLocation = UserInputService:GetMouseLocation()
		
		MouseIcon.Position = UDim2.new(0, MouseLocation.X, 0, MouseLocation.Y)
		
		if CursorScaling then
			local ScaledMouseIconSize = MouseIconSize / (Camera.CFrame.Position - Raycast.Position).Magnitude
			
			MouseIcon.Size = UDim2.new(0, ScaledMouseIconSize, 0, ScaledMouseIconSize)
		end
	end
	
	if OnScanner and Down then
		local ScanBarModel = Scanner:FindFirstChild("Bar")
		
		if ScanBarModel then
			local ScanBar = ScanBarModel:FindFirstChild("Bar")
			if ScanBar then
				if not ScanBar:GetAttribute("Progress") then
					ScanBar:SetAttribute("Progress", 0)
				end
				
				local Progress = math.clamp(ScanBar:GetAttribute("Progress") + DeltaTime / ScanDoor:GetAttribute("ScanTime"), 0, 1)
				
				ScanBar:SetAttribute("Progress", Progress)
				
				local ScanBarTable = ScanBar:GetChildren()
				local ScanBarAmount = #ScanBarTable
				
				for _, Bar in pairs(ScanBarTable) do
					local BarProgress = math.clamp(Progress * ScanBarAmount - tonumber(Bar.Name:sub(4)) + 1, 0, 1)
					
					if BarProgress > 0 then
						Bar.Transparency = 0
						
						Bar.Size = Bar.SizeValue.Value * Vector3.new(BarProgress, 1, 1)
						Bar.CFrame = Bar.OriginValue.Value * CFrame.new(Bar.Size.X / 2, 0, 0)
					else
						Bar.Transparency = 1
					end
				end
				
				if Progress >= 1 then
					if ScanBar:GetAttribute("Scanned") ~= true then
						ScanDoorRE:FireServer({Event = "OpenDoor", Door = ScanDoor})
					end
					
					ScanBar:SetAttribute("Scanned", true)
				end
				
				LastScanner = Scanner
			end
		end
	else
		if LastScanner then
			local ScanBarModel = LastScanner.Bar
			local ScanBar = ScanBarModel.Bar
			
			ScanBar:SetAttribute("Progress", 0)
			
			ScanBar:SetAttribute("Scanned", false)
			
			for _, Bar in pairs(ScanBar:GetChildren()) do
				Bar.Transparency = 1
			end
			
			LastScanner = nil
		end
	end
end)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ScanDoorRE = ReplicatedStorage.ScanDoorRE
local ScanDoorRF = ReplicatedStorage.ScanDoorRF

local ScanDoorModule = {}
local OpenedDoors = {}

function ScanDoorModule:Init(ScanDoor)
	ScanDoor:SetAttribute("ScanDoor", true)
	
	local ScannerModel = ScanDoor.Scanner
	local ScanBarModel = ScannerModel.Bar
	local ScanBar = ScanBarModel.Bar
	
	for _, Bar in pairs(ScanBar:GetChildren()) do
		Bar.Transparency = 1
		
		local OriginValue = Instance.new("CFrameValue")
		OriginValue.Name = "OriginValue"
		OriginValue.Value = Bar.CFrame * CFrame.new(-Bar.Size.X / 2, 0, 0)
		OriginValue.Parent = Bar
		
		local SizeValue = Instance.new("Vector3Value")
		SizeValue.Name = "SizeValue"
		SizeValue.Value = Bar.Size
		SizeValue.Parent = Bar
	end
	
	local Door = ScanDoor.Door
	
	local OriginValue = Instance.new("CFrameValue")
	OriginValue.Name = "OriginValue"
	OriginValue.Value = Door.Main.CFrame
	OriginValue.Parent = Door
end

ScanDoorRE.OnServerEvent:Connect(function(Player, Data)
	local Event = Data.Event
	
	if Event == "OpenDoor" and Data.Door and Data.Door:GetAttribute("ScanDoor") == true then
		local OpenedDoor = table.find(OpenedDoors, Data.Door)
		
		if OpenedDoor then
			if Data.Door:GetAttribute("ScanToClose") == true then
				table.remove(OpenedDoors, OpenedDoor)
				
				ScanDoorRE:FireAllClients({Event = "CloseDoor", Door = Data.Door})
				
				Data.Door:SetAttribute("Closing", true)
			end
		else
			table.insert(OpenedDoors, Data.Door)
			
			ScanDoorRE:FireAllClients({Event = "OpenDoor", Door = Data.Door})
			
			Data.Door:SetAttribute("Closing", false)
			
			if Data.Door:GetAttribute("CloseAutomatically") == true then
				local Closing = true
				local Connection = nil
				
				if Data.Door:GetAttribute("ScanToClose") == true then
					Connection = Data.Door:GetAttributeChangedSignal("Closing"):Connect(function()
						if Data.Door:GetAttribute("Closing") == true then
							Closing = false
							
							if Connection then
								Connection:Disconnect()
								Connection = nil
							end
						end
					end)
				end
				
				task.wait(Data.Door:GetAttribute("CloseAfterTime"))
				
				if Closing then
					table.remove(OpenedDoors, OpenedDoor)
					
					ScanDoorRE:FireAllClients({Event = "CloseDoor", Door = Data.Door})
				end
				
				if Connection then
					Connection:Disconnect()
					Connection = nil
				end
			end
		end
	end
end)

ScanDoorRF.OnServerInvoke = function(Player, Data)
	local Event = Data.Event
	
	if Event == "GetOpenedDoors" then
		return OpenedDoors
	end
end

return ScanDoorModule
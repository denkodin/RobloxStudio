--[[                 Made by denkodin
YouTube channels:
https://www.youtube.com/c/H2MinRobloxStudio
http://www.youtube.com/c/EasyQuestinRobloxStudio
                      License to use
What is allowed?
You are allowed to use this script in your games without restrictions, including monetize games.
What is forbidden?
It is forbidden to sell and distribute in any way this script. And you may not claim you are the creator or copyright holder one.
It is forbidden to remove this comment from the script.
]]
local Tool = script.Parent
local AnimationR15 = script:WaitForChild("AnimationR15", 1)
local AnimationR6 = script:WaitForChild("AnimationR6", 1)

Tool.Activated:Connect(function()
	local Character = Tool.Parent
	if Character then
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
		if Humanoid then
			local LoadedAnim = nil
			if Humanoid.RigType == Enum.HumanoidRigType.R15 and AnimationR15 then
				LoadedAnim = Humanoid:LoadAnimation(AnimationR15)
			elseif Humanoid.RigType == Enum.HumanoidRigType.R6 and AnimationR6 then
				LoadedAnim = Humanoid:LoadAnimation(AnimationR6)
			end
			if LoadedAnim then
				LoadedAnim:Play()
			end
		end
	end
end)

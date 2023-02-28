local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local AdminBar = script.Parent
local switch = false
local Info = TweenInfo.new(1, Enum.EasingStyle.Back)
local TweenIn = TweenService:Create(AdminBar.Frame, Info, {Position = UDim2.new(0.5, 0, 0.85, 0)})
local TweenOut = TweenService:Create(AdminBar.Frame, Info, {Position = UDim2.new(0.5, 0, 1.1, 0)})

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
	if gameProcessedEvent then return end
	if player.PlayerGui:FindFirstChild("AdminBar") then
		switch = not switch
		if input.KeyCode == Enum.KeyCode.C then
			if switch then
				TweenIn:Play()
			else
				TweenOut:Play()
			end
		end
	end
end)

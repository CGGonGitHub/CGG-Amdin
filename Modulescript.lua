-- script made by thereal#5282 with much help from Censor#3035
-- put this script in ServerScriptService and name it however you like

--[[ Variables ]]--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local commands = {}

--[[ Functions]]--
local function getPlayer(pattern: string, whoFired)
	if pattern == "Me" or "me" then
		return whoFired;
	elseif pattern == "All" or "all" then
		return Players:GetPlayers()
	else
		for index, player in next, Players:GetPlayers() do
			if player.Name:match(pattern) or player.DisplayName:match(pattern) then
				return player;
		end
	end
		
		return nil;
	end
end

function commands.kill(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			p.Character.Humanoid.Health = 0
		end
	else
		player.Character.Humanoid.Health = 0
	end
end

function commands.anchor(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player.Character.HumanoidRootPart.Anchored = true
		end
	else
		player.Character.HumanoidRootPart.Anchored = true
	end
end

function commands.unanchor(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = false
		end
	else
		player.Character.HumanoidRootPart.Anchored = false
	end
end

function commands.walkspeed(whoFired, player, number)
	player = getPlayer(player, whoFired)
	local walkspeed = tonumber(number)
	if type(player) == "table" then
		for _, p in player do
			player.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
		end
	else
		player.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
	end
end
function commands.bring(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player.Character.HumanoidRootPart.CFrame = whoFired.Character.HumanoidRootPart.CFrame
		end
	else
		player.Character.HumanoidRootPart.CFrame = whoFired.Character.HumanoidRootPart.CFrame
	end
end

function commands.bringall(whoFired)
	for i, v in Players:GetPlayers() do
		if not v.Character then continue end;
		v.Character.HumanoidRootPart.CFrame = whoFired.Character.HumanoidRootPart.CFrame
	end
end

function commands.teleport(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			whoFired.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
		end
	else
		whoFired.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
	end
end

function commands.teleportall(whoFired, player)
	player = getPlayer(player, whoFired)
	for i, v in Players:GetPlayers() do
		if not v.Character then continue end;
		v.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
	end
end

function commands.loadchar(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player:LoadCharacter()
		end
	else
		player:LoadCharacter()
	end
end

function commands.invisible(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			for i, v in player.Character:GetChildren() do
				if v:IsA("BasePart") then
					if v.Name == "HumanoidRootPart" then

					else
						v.Transparency = 1
					end
				end
			end
			for i, v in player.Character:GetChildren() do
				if v:IsA("Accessory") then
					v.Handle.Transparency = 1
				end
			end
			player.Character.Head.face.Transparency = 1
			player.Character.DisplayName.TextLabel.TextTransparency = 1
			player.Character.DisplayName.TextLabel.TextStrokeTransparency = 1
		end
	else
		for i, v in player.Character:GetChildren() do
			if v:IsA("BasePart") then
				if v.Name == "HumanoidRootPart" then

				else
					v.Transparency = 1
				end
			end
		end
		for i, v in player.Character:GetChildren() do
			if v:IsA("Accessory") then
				v.Handle.Transparency = 1
			end
		end
		player.Character.Head.face.Transparency = 1
		player.Character.DisplayName.TextLabel.TextTransparency = 1
		player.Character.DisplayName.TextLabel.TextStrokeTransparency = 1
	end
end
function commands.uninvisible(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			for i, v in player.Character:GetChildren() do
				if v:IsA("BasePart") then
					if v.Name == "HumanoidRootPart" then

					else
						v.Transparency = 0
					end
				end
			end
			for i, v in player.Character:GetChildren() do
				if v:IsA("Accessory") then
					v.Handle.Transparency = 0
				end
			end
			player.Character.Head.face.Transparency = 0
			player.Character.DisplayName.TextLabel.TextTransparency = 0
			player.Character.DisplayName.TextLabel.TextStrokeTransparency = 0
		end
	else
		for i, v in player.Character:GetChildren() do
			if v:IsA("BasePart") then
				if v.Name == "HumanoidRootPart" then

				else
					v.Transparency = 0
				end
			end
		end
		for i, v in player.Character:GetChildren() do
			if v:IsA("Accessory") then
				v.Handle.Transparency = 0
			end
		end
		player.Character.Head.face.Transparency = 0
		player.Character.DisplayName.TextLabel.TextTransparency = 0
		player.Character.DisplayName.TextLabel.TextStrokeTransparency = 0
	end
end
function commands.removegrass(whoFired)
	if workspace:FindFirstChild("Grass") then
		workspace.Grass.Parent = ReplicatedStorage
	end
end

function commands.addgrass(whoFired)
	if ReplicatedStorage:FindFirstChild("Grass") then
		ReplicatedStorage.Grass.Parent = workspace
	end
end

function commands.setdisplay(whoFired, player, arg1)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player.Character.DisplayName.TextLabel.Text = arg1
		end
	else
		player.Character.DisplayName.TextLabel.Text = arg1
	end
end

function commands.kick(whoFired, player, arg1)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player:Kick(arg1)
		end
	else
		player:Kick(arg1)
	end
end

function commands.print(whoFired, arg1)
	print(arg1)
end

function commands.sword(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			local x = ReplicatedStorage.ClassicSword:Clone()
			x.Parent = player.Backpack
		end
	else
		local x = ReplicatedStorage.ClassicSword:Clone()
			x.Parent = player.Backpack
	end
end

function commands.kidnap(whoFired, player)
	player = getPlayer(player, whoFired)
	if type(player) == "table" then
		for _, p in player do
			player.Character.HumanoidRootPart.Anchored = true
			local info = TweenInfo.new(2.5)
			local x = ReplicatedStorage.Van:Clone()
			x.Parent = workspace
			x.Position = player.Character.HumanoidRootPart.Position + Vector3.new(30,0,0)
			x.CFrame = CFrame.lookAt(x.Position, player.Character.HumanoidRootPart.Position)
			local tween1 = TweenService:Create(x, info, {Position = player.Character.HumanoidRootPart.Position})
			local tween2 = TweenService:Create(x, info, {Position =  player.Character.HumanoidRootPart.Position + Vector3.new(-30,0,0)})
			tween1:Play()
			task.wait(0.5)
			player.Character.Humanoid.Health = 0
			tween2:Play()
			tween2.Completed:Connect(function()
				x:Destroy()
			end)
		end
	else
		player.Character.HumanoidRootPart.Anchored = true
		local info = TweenInfo.new(2.5)
		local x = ReplicatedStorage.Van:Clone()
		x.Parent = workspace
		x.Position = player.Character.HumanoidRootPart.Position + Vector3.new(30,0,0)
		x.CFrame = CFrame.lookAt(x.Position, player.Character.HumanoidRootPart.Position)
		local tween1 = TweenService:Create(x, info, {Position = player.Character.HumanoidRootPart.Position})
		local tween2 = TweenService:Create(x, info, {Position =  player.Character.HumanoidRootPart.Position + Vector3.new(-30,0,0)})
		tween1:Play()
		task.wait(0.5)
		player.Character.Humanoid.Health = 0
		tween2:Play()
		tween2.Completed:Connect(function()
			x:Destroy()
			end)
	end
end

return commands

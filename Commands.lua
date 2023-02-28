--[[ Variables ]]--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")
local InsertService = game:GetService("InsertService")
local configs = require(script.Parent.Configures)
local groupId = configs.groupId
local modrank = configs.modrank
local commands = {}

--[[ Functions]]--
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
local function getPlayer(whoFired: string, pattern: string)
	if string.match(pattern, "Me") or string.match(pattern, "me") then
		return whoFired;
	elseif string.match(pattern, "All") or string.match(pattern, "all") then
		return Players:GetPlayers();
	else
		for index, player in next, Players:GetPlayers() do
			if player.Name:match(pattern) or player.DisplayName:match(pattern) then
				return player;
			end
		end

		return nil;
	end
end
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------
function commands.settempadmin(whoFired, player)
	player = getPlayer(whoFired, player)
	if configs.PermissionTable[player] > 4 then
		if type(player) == "table" then
			for _, p in player do
				local playerId = player.UserId
				table.insert(configs.tempadmins, playerId)
				commands.refreshranks(whoFired, player)
				local x = game.ServerStorage.AdminBar:Clone()
				x.Parent = p.PlayerGui
			end
		else
			local playerId = player.UserId
			table.insert(configs.tempadmins, playerId)
			commands.refreshranks(whoFired, player)
			local x = game.ServerStorage.AdminBar:Clone()
			x.Parent = player.PlayerGui
		end
	end
end

function commands.settempmod(whoFired, player)
	player = getPlayer(whoFired, player)
	if configs.PermissionTable[player] > 5 then
		if type(player) == "table" then
			for _, p in player do
				local playerId = player.UserId
				table.insert(configs.tempmods, playerId)
				commands.refreshranks(whoFired, player)
				local x = game.ServerStorage.AdminBar:Clone()
				x.Parent = p.PlayerGui
			end
		else
			local playerId = player.UserId
			table.insert(configs.tempmods, playerId)
			commands.refreshranks(whoFired, player)
			local x = game.ServerStorage.AdminBar:Clone()
			x.Parent = player.PlayerGui
		end
	end
end

function commands.removetempadmin(whoFired, player)
	player = getPlayer(whoFired, player)
	if configs.PermissionTable[player] > 4 then
		if type(player) == "table" then
			for _, p in player do
				local playerId = player.UserId
				table.remove(configs.tempadmins, playerId)
				commands.refreshranks(whoFired, player)
			end
		else
			local playerId = player.UserId
			table.remove(configs.tempadmins, playerId)
			commands.refreshranks(whoFired, player)
		end
	end
end

function commands.removetempmod(whoFired, player)
	player = getPlayer(whoFired, player)
	if configs.PermissionTable[player] > 5 then
		if type(player) == "table" then
			for _, p in player do
				local playerId = player.UserId
				table.remove(configs.tempmods, playerId)
				commands.refreshranks(whoFired, player)
			end
		else
			local playerId = player.UserId
			table.remove(configs.tempmods, playerId)
			commands.refreshranks(whoFired, player)
		end
	end
end

function commands.kill(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.Humanoid.Health = 0
		end
	else
		player.Character.Humanoid.Health = 0
	end
end

function commands.anchor(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = true
		end
	else
		player.Character.HumanoidRootPart.Anchored = true
	end
end

function commands.unanchor(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = false
		end
	else
		player.Character.HumanoidRootPart.Anchored = false
	end
end

function commands.freeze(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = true
		end
	else
		player.Character.HumanoidRootPart.Anchored = true
	end
end

function commands.unfreeze(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = false
		end
	else
		player.Character.HumanoidRootPart.Anchored = false
	end
end

function commands.walkspeed(whoFired, player, number)
	player = getPlayer(whoFired, player)
	local walkspeed = tonumber(number)
	if type(player) == "table" then
		for _, p in player do
			p.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
		end
	else
		player.Character:WaitForChild("Humanoid").WalkSpeed = walkspeed
	end
end

function commands.bring(whoFired, player)
	player = getPlayer(whoFired, player)
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
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			whoFired.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
		end
	else
		whoFired.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
	end
end

function commands.teleportall(whoFired, player)
	player = getPlayer(whoFired, player)
	for i, v in Players:GetPlayers() do
		if not v.Character then continue end;
		v.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
	end
end

function commands.loadchar(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p:LoadCharacter()
		end
	else
		player:LoadCharacter()
	end
end

function commands.invisible(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			for i, v in p.Character:GetChildren() do
				if v:IsA("BasePart") then
					if v.Name == "HumanoidRootPart" then

					else
						v.Transparency = 1
					end
				end
			end
			for i, v in p.Character:GetChildren() do
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
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			for i, v in p.Character:GetChildren() do
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
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.DisplayName.TextLabel.Text = arg1
		end
	else
		player.Character.DisplayName.TextLabel.Text = arg1
	end
end

function commands.kick(whoFired, player, arg1)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p:Kick(arg1)
		end
	else
		player:Kick(arg1)
	end
end

function commands.print(whoFired, arg1)
	print(arg1)
end

function commands.sword(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			local x = ReplicatedStorage.ClassicSword:Clone()
			x.Parent = p.Backpack
		end
	else
		local x = ReplicatedStorage.ClassicSword:Clone()
		x.Parent = player.Backpack
	end
end

function commands.kidnap(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.HumanoidRootPart.Anchored = true
			local info = TweenInfo.new(2.5)
			local x = ReplicatedStorage.Van:Clone()
			x.Parent = workspace
			x.Position = p.Character.HumanoidRootPart.Position + Vector3.new(30,0,0)
			x.CFrame = CFrame.lookAt(x.Position, p.Character.HumanoidRootPart.Position)
			local tween1 = TweenService:Create(x, info, {Position = p.Character.HumanoidRootPart.Position})
			local tween2 = TweenService:Create(x, info, {Position =  p.Character.HumanoidRootPart.Position + Vector3.new(-30,0,0)})
			tween1:Play()
			task.wait(0.5)
			p.Character.Humanoid.Health = 0
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

function commands.headsize(whoFired, player, amount)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			local x = Players:GetHumanoidDescriptionFromUserId(p.UserId)
			x.HeadScale = amount
		end
	else
		local x = Players:GetHumanoidDescriptionFromUserId(player.UserId)
		x.HeadScale = amount
	end
end

function commands.char(whoFired, player, target)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			local userId = Players:GetUserIdFromNameAsync(target)
			local description = Players:GetHumanoidDescriptionFromUserId(userId)
			p.Character.Humanoid:ApplyDescription(description)
		end
	else
		local userId = Players:GetUserIdFromNameAsync(target)
		local description = Players:GetHumanoidDescriptionFromUserId(userId)
		player.Character.Humanoid:ApplyDescription(description)
	end
end

function commands.jumppower(whoFired, player, amount)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.Humanoid.UseJumpPower = true
			p.Character.Humanoid.JumpPower = amount
		end
	else
		player.Character.Humanoid.UseJumpPower = true
		player.Character.Humanoid.JumpPower = amount
	end
end

function commands.refreshranks(whoFired, player)
	if player.UserId == game.CreatorId then
		configs.PermissionTable[player] = 5 -- For Owner
	elseif player:GetRankInGroup(configs.groupId) > configs.modrank or table.find(configs.mods, player.UserId) then
		configs.PermissionTable[player] = 4 -- For Mods
	elseif player:GetRankInGroup(configs.groupId) > configs.adminrank or table.find(configs.admins, player.UserId) then
		configs.PermissionTable[player] = 3 -- For Admins
	else
		configs.PermissionTable[player] = 1 -- No Perms!11! LLL
	end
end

function commands.headless(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.Head.Transparency = 1
			p.Character.Head.face.Transparency = 1
		end
	else
		player.Character.Head.Transparency = 1
		player.Character.Head.face.Transparency = 1
	end
end

function commands.unheadless(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			p.Character.Head.Transparency = 0
			p.Character.Head.face.Transparency = 0
		end
	else
		player.Character.Head.Transparency = 0
		player.Character.Head.face.Transparency = 0
	end
end

function commands.korblox(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			local Humanoid = p.Character:WaitForChild("Humanoid")
			local Description = Humanoid:GetAppliedDescription()
			Description.RightLeg = 139607718
			Humanoid:ApplyDescription(Description)
		end
	else
		local Humanoid = player.Character:WaitForChild("Humanoid")
		local Description = Humanoid:GetAppliedDescription()
		Description.RightLeg = 139607718
		Humanoid:ApplyDescription(Description)
	end
end

function commands.gravity(whoFired, amount)
	workspace.Gravity = amount
end

function commands.musicplay(whoFired, Id)
	for i, v in workspace:GetChildren() do
		if v.Name == "Music from CGGAdmin" then
			v:Destroy()
		end
	end
	Id = tonumber(Id)
	local x = Instance.new("Sound")
	x.SoundId = Id
	x.Name = "Music from CGGAdmin"
	x.Parent = workspace
	x:Play()
end

function commands.musicpause()
	local x = workspace:FindFirstChild("Music from CGGAdmin")
	if x then
		x:Pause()
	end
end

function commands.musicresume()
	local x = workspace:FindFirstChild("Music from CGGAdmin")
	if x then
		x:Resume()
	end
end

function commands.musicstop()
	local x = workspace:FindFirstChild("Music from CGGAdmin")
	if x then
		x:Stop()
	end
end

function commands.lag(whoFired, player)
	player = getPlayer(whoFired, player)
	if type(player) == "table" then
		for _, p in player do
			local lag
			lag = not lag
			while lag do
				p.Character.HumanoidRootPart.Anchored = not p.Character.HumanoidRootPart.Anchored
				task.wait()
				if not lag then
					p.Character.HumanoidRootPart.Anchored = false
				end
			end
		end
	else
		local lag
		lag = not lag
		while lag do
			player.Character.HumanoidRootPart.Anchored = not player.Character.HumanoidRootPart.Anchored
			task.wait()
			if not lag then
				player.Character.HumanoidRootPart.Anchored = false
				break
			end
		end
	end
end

function commands.rejoin(whoFired, player)
	player = getPlayer(whoFired, player)
	local JobId = game.JobId
	local PlaceId = game.PlaceId
	if type(player) == "table" then
		for _, p in player do
			game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, JobId, p)
		end
	else
		game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceId, JobId, player)
	end
end

return commands

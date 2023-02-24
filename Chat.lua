--[[ Variables ]]--
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local DataStoreService = game:GetService("DataStoreService")
script.Parent.Parent = ServerScriptService
local commands = require(ServerScriptService["CGG Admin"].Commands)
local configures = require(ServerScriptService["CGG Admin"].Configures)
local prefix = "!"

--[[ Functions]]--

local adminStore = DataStoreService:GetDataStore("Admins")
local modStore = DataStoreService:GetDataStore("Mods")
while true do
	local success, updatedTable = pcall(function()
		return adminStore:UpdateAsync(configures.admins)
	end)
	local success, updatedTable = pcall(function()
		return modStore:UpdateAsync(configures.mods)
	end)
	task.wait(60)
end

Players.PlayerAdded:Connect(function(player)
	if player.UserId == game.CreatorId then
		configures.PermissionTable[player] = 5 -- For Owner
	elseif player:GetRankInGroup(configures.groupId) > configures.modrank or table.find(configures.mods, player.UserId) then
		configures.PermissionTable[player] = 4 -- For Mods
	elseif player:GetRankInGroup(configures.groupId) > configures.adminrank or table.find(configures.admins, player.UserId) then
		configures.PermissionTable[player] = 3 -- For Admins
	else
		configures.PermissionTable[player] = 1 -- No Perms!11! LLL
	end
end)

function getArgs(splitmsg)
	local inString = false
	local newIndex = 1
	local args = {}
	for _, element in splitmsg do
		
		local numChars = string.len(element)
		
		if element:sub(1,1) == '"' then
			inString = true
		end
		if element:sub(numChars, numChars) == '"' then
			inString = false
		end
		element = string.gsub(element, '"', "")
		if args[newIndex] then
			args[newIndex] = args[newIndex].." "..element
		else
			args[newIndex] = element
		end
		if not inString then
			newIndex += 1
		end
	end
	table.remove(args, 1)
	return args
end
-- made by Cens_r
Players.PlayerAdded:Connect(function(player)
	player.Chatted:Connect(function(msg)
		if string.sub(msg,1,1) == prefix then
			local playerId = player.UserId
			local groupId = configures.groupId
			local adminrank = configures.groupId
			if configures.PermissionTable[player] > 3 then
				local prefixsplitmsg = string.split(msg, prefix)
				local splitmsg = string.split(prefixsplitmsg[2], " ")
				local args = getArgs(splitmsg)
				local lowercommand = string.lower(splitmsg[1])
				if commands[lowercommand] then
					commands[lowercommand](player, table.unpack(args))
				end
			end
		end
	end)
end)

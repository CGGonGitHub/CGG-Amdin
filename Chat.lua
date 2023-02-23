--[[ Variables ]]--
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
script.Parent.Parent = ServerScriptService
local commands = require(script.Parent.Commands)
local configs = require(script.Parent.Configures)
local prefix = "!"
local ownerId = game.CreatorId

--[[ Functions]]--
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
			local groupId = configs.groupId
			local adminrank = configs.groupId
			local mods = configs.mods
			local admins = configs.admins
			if player:GetRankInGroup(groupId) > adminrank or table.find(mods, player.Name) or table.find(mods, playerId) or table.find(admins, player.Name) or table.find(admins, playerId) then
				local prefixsplitmsg = string.split(msg, prefix)
				local splitmsg = string.split(prefixsplitmsg[2], " ")
				print(splitmsg)
				local args = getArgs(splitmsg)
				local lowercommand = string.lower(splitmsg[1])
				if commands[lowercommand] then
					commands[lowercommand](player, table.unpack(args))
				end
			end
		end
	end)
end)

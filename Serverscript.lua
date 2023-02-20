-- set the groupId to the group id of your group
-- all members who have a role that is higher than this number have admin
local groupId = 14858739
local rank = 199

--[[ Variables ]]--
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local commands = require(ServerScriptService.Admin.Commands)
local prefix = "!"
local lowercommand
local prefixsplitmsg
local splitmsg
local player

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
			if player:GetRankInGroup(groupId) > rank then
				prefixsplitmsg = string.split(msg, prefix)
				splitmsg = string.split(prefixsplitmsg[2], " ")
				print(splitmsg)
				local args = getArgs(splitmsg)
				lowercommand = string.lower(splitmsg[1])
				if commands[lowercommand] then
					commands[lowercommand](player, table.unpack(args))
				end
			end
		end
	end)
end)

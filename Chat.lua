--[[ Variables ]]--
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
script.Parent.Parent = ServerScriptService
local commands = require(ServerScriptService["CGG Admin"].Commands)
local configures = require(ServerScriptService["CGG Admin"].Configures)
local prefix = configures.prefix

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
	commands.refreshranks("pp", player)
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

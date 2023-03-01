--[[ Variables ]]--
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")
local AdminBar = script.Parent.AdminBar
AdminBar.Parent = ServerStorage
local commands = require(ServerScriptService["CGG Admin"].Commands)
local configures = require(ServerScriptService["CGG Admin"].Configures)
local Event = ReplicatedStorage.AdminBarEvent

--[[ Functions]]--
Players.PlayerAdded:Connect(function(player)
	commands.refreshranks("pp", player)
	if configures.PermissionTable[player.UserId] > 2.9 then
		local x = game.ServerStorage.AdminBar:Clone()
		x.Parent = player.PlayerGui		
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

Event.OnServerEvent:Connect(function(player, input)
	local playerId = player.UserId
	local groupId = configures.groupId
	local adminrank = configures.groupId
	if configures.PermissionTable[player.UserId] > 2.9 then
		local splitmsg = string.split(input, " ")
		local args = getArgs(splitmsg)
		local lowercommand = string.lower(splitmsg[1])
		if commands[lowercommand] then
			commands[lowercommand](player, table.unpack(args))
		end
	end
end)

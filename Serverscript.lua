-- [[ Setup ]] --
local groupId = 14858739  -- Set this to your groupId if you want to use your Group to manage Admins
local rank = 199 -- anyone that has a higher rank than this will have admin

-- !! mods will be able to temporarily make players have admin and have the right to ban people!! --
local mods = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}
-- !! admins have access to all commands except 'ban' and 'setadmin' !! --
-- list playerId's or USERNAMES (not displaynames!!!) here
local admins = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}


--[[ Variables ]]--
local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local commands = require(ServerScriptService.Admin.Commands)
local prefix = "!"
local ownerId = game.CreatorId
local lowercommand
local prefixsplitmsg
local splitmsg
local player
local playerId

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
			playerId = player.UserId
			if player:GetRankInGroup(groupId) > rank or table.find(mods, player.Name) or table.find(mods, playerId) or table.find(admins, player.Name) or table.find(admins, playerId) then
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

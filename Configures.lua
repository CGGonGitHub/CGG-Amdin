-- [[ Setup ]] --


local configures = {}

configures.groupId = 14858739  -- Set this to your groupId if you want to use your Group to manage Admins
configures.modrank = 254 -- anyone that has a higher rank than this will have mod, they can ban players and set temporary admins (only for the active server)
configures.adminrank = 200 -- anyone that has a higher rank than this will have admin

-- [[ These are temporary, meaning they will only have the rights do to admin commands on the server they're currently on ]]

-- !! mods will be able to temporarily make players have admin and have the right to ban people!! --
-- list playerId's or USERNAMES (not displaynames!!!) here
-- only the owner can make mods
configures.mods = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}
-- !! admins have access to all commands except 'ban' and 'setadmin' !! --
-- list playerId's or USERNAMES (not displaynames!!!) here
configures.admins = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------------

-- [[ These are permanent, meaning they will ALWAYS have the rights in ANYserver ]]
-- !! mods will be able to temporarily make players have admin and have the right to ban people!! --
-- list playerId's or USERNAMES (not displaynames!!!) here
-- only the owner can make tempmods
configures.tempmods = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}
-- !! admins have access to all commands except 'ban' and 'setadmin' !! --
-- list playerId's or USERNAMES (not displaynames!!!) here
configures.tempmods = {
	"CGGonRoblox"; -- put usernames in quotation marks ("")
	1136054560; -- userId's can be left raw
}

return configures

QBCore = exports['qb-core']:GetCoreObject()

-- This function will return the player's identifier (identifier or id)
function getIdentifier(source)
	local Player = QBCore.Functions.GetPlayer(source)
	
	if Player then
		return QBCore.Functions.GetIdentifier(source, 'license')
	end
end

-- Here you define the function that takes the name of the player
function getName(source)
	local Player = QBCore.Functions.GetPlayer(source)
	if Player then
		name = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname
	end

	return name
end
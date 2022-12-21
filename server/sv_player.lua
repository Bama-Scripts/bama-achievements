QBCore = exports['qb-core']:GetCoreObject()
players = {}

-- MYSQL FUNCTIONS ------
CreateThread(function()
	MySQL.Async.execute("CREATE TABLE IF NOT EXISTS player_kd (id int AUTO_INCREMENT, identifier text, name varchar(100), kills int, deaths int, score int, PRIMARY KEY(id))", {},
	function()
		MySQL.Async.fetchAll("SELECT * FROM player_kd", {}, function(result) players = result end)
	end)
end)

function updateBoard(identifier, kills, deaths, score)
	MySQL.Async.execute("UPDATE player_kd SET kills = :kills, deaths = :deaths, score = :score WHERE identifier = :identifier", {
		kills = kills,
		deaths = deaths,
		score = score,
		identifier = identifier,
	}, function() end)
end

function insertBoard(identifier, name, kills, deaths, score)
	MySQL.Async.execute("INSERT INTO player_kd (identifier, name, kills, deaths, score) VALUES (:identifier, :name, :kills, :deaths, :score)", {
		identifier = identifier,
		name = name,
		kills = kills,
		deaths = deaths,
		score = score,
	}, function() end)
end



QBCore.Functions.CreateCallback('bama-achievements:server:GetPlayerKD', function (source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local result = MySQL.single.await('SELECT * FROM player_kd WHERE identifier = ?', {license})
	print(QBCore.Debug(result))
    if result ~= nil then
        cb(result)
    else
        cb(nil)
    end
end)

RegisterNetEvent('bama-achievements:server:UpdateBoard')
AddEventHandler('bama-achievements:server:UpdateBoard', function(sourceKiller)
	local sourceVictim = source
	local identifierVictim = getIdentifier(sourceVictim)
	local identifierKiller = getIdentifier(sourceKiller)
	if(identifierKiller == identifierVictim) then
		return
	end
	if not isDead(sourceVictim) then
		return
	end    
	local foundKiller = false
	local foundVictim = false
	for i,k in pairs(players) do
		if k.identifier == identifierKiller then
			k.kills = tonumber(k.kills) + 1
			updateBoard(identifierKiller, k.kills, k.deaths, k.score)
			foundKiller = true
		elseif k.identifier == identifierVictim then
			k.deaths = tonumber(k.deaths) + 1
			updateBoard(identifierVictim, k.kills, k.deaths, k.score)
			foundVictim = true
		end
	end
	if not foundKiller then
		table.insert(players, {
			identifier = identifierKiller,
			name = getName(sourceKiller),
			kills = 1,
			deaths = 0,
			score = Config.kill_score,
		})
		insertBoard(identifierKiller, getName(sourceKiller), 1, 0, Config.kill_score)
	end
	if not foundVictim then
		table.insert(players, {
			identifier = identifierVictim,
			name = getName(sourceVictim),
			kills = 0,
			deaths = 1,
			score = 0,
		})
		insertBoard(identifierVictim, getName(sourceVictim), 0, 1, 0)
	end
	

end)
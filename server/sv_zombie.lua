QBCore = exports['qb-core']:GetCoreObject()
players = {}

CreateThread(function()
    MySQL.Async.execute("CREATE TABLE IF NOT EXISTS zombie_kills (id int AUTO_INCREMENT, identifier text, name varchar(100), kills int, PRIMARY KEY(id))", {},
    function()
        MySQL.Async.fetchAll("SELECT * FROM zombie_kills", {}, function(result) players = result end)
    end)
end)

function updateBoard2(identifier, kills)
    MySQL.Async.execute("UPDATE zombie_kills SET kills = :kills WHERE identifier = :identifier", {
        kills = kills,
        identifier = identifier,
    }, function() end)
end

function insertBoard2(identifier, name, kills)
    MySQL.Async.execute("INSERT INTO zombie_kills (identifier, name, kills) VALUES (:identifier, :name, :kills)", {
        identifier = identifier,
        name = name,
        kills = kills,
    }, function() end)
end

QBCore.Functions.CreateCallback('bama-achievements:server:GetPlayerZombieKills', function (source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local result = MySQL.single.await('SELECT * FROM zombie_kills WHERE identifier = ?', {license})
    if result ~= nil then
        cb(result)
    else
        cb(nil)
    end
end)

RegisterNetEvent('bama-achievements:server:ZombieKill', function (sourcekiller)
    local identifierKiller = getIdentifier(source)
    local foundKiller = false

    for i,k in pairs(players) do
        if k.identifier == identifierKiller then
            k.kills = tonumber(k.kills) + 1

            updateBoard2(identifierKiller, k.kills)

            foundKiller = true
        end
    end

    if not foundKiller then
        table.insert(players, {
            identifier = identifierKiller,
            name = getName(sourceKiller),
            kills = 1,
        })
        print(getName(sourcekiller))
        insertBoard2(identifierKiller, getName(sourceKiller), 1)
    end
end)



--- Add to readme that they have to place "TriggerServerEvent'bama-achievements:server:ZombieKill', sourceKiller" into thier zombie script
-- EXAMPLE:
--[[
    -- THIS IS THE EVENT HANDLER FOR HRS_ZOMBIES
    AddEventHandler('onZombieDied', function(entity)
    local ped = PlayerPedId()
    local killerPed = GetPedSourceOfDeath(entity)
    local player = NetworkGetPlayerIndexFromPed(killerPed)
	local sourceKiller = GetPlayerServerId(player)
    if killerPed == ped then
        exports.xperience:AddXP(math.random(10, 25))
        TriggerServerEvent('lg_leaderboard:UpdateBoard2', sourceKiller)
        TriggerServerEvent('bama-achievements:server:ZombieKill', sourceKiller)
    end
end)
]]


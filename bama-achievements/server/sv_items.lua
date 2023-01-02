QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateCallback('bama-achievements:server:GetPlayerItemAmount', function (source, cb, item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local getitems = Player.Functions.GetItemsByName(item)
    local ItemList = {}
    if getitems[1] ~= nil then
        cb(getitems[1])
    end
end)
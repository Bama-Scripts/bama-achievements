QBCore = exports['qb-core']:GetCoreObject()

---------- EVENTS -------------------
-- Unlock Achievement Upon Clicking on the Achievement in the menu
RegisterNetEvent('bama-achievements:server:ClaimAchievement', function (data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local item = Player.Functions.GetItemByName(Config.Achievements[data.id][data.achievement].item)
    local configitem = Config.Achievements[data.id][data.achievement].item
    local itemamount = Config.Achievements[data.id][data.achievement].amount
    local reward = Config.Achievements[data.id][data.achievement].reward
    local rewardtype = Config.Achievements[data.id][data.achievement].rewardtype
    local discord = "<@"..QBCore.Functions.GetIdentifier(src, 'discord'):gsub("discord:", "")..">"
    local charname = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    local result = MySQL.single.await('SELECT * FROM achievements WHERE license = ? AND achievement = ?', {license, data.achievement})
    if result ~= nil then
        TriggerClientEvent('QBCore:Notify', src, 'Achievement Has Already Been Unlocked', 'warning')
    else
        if Player then
            MySQL.insert('INSERT INTO achievements (`license`, `citizenid`, `achievement`, `unlocked`) VALUES (?, ?, ?, ?)', {
                license,
                Player.PlayerData.citizenid,
                data.achievement,
                1,
            })
        end
        if data.Item ~= nil then
            if not Config.AllowPlayerExchange then
                if item.info.achievement then
                    TriggerClientEvent('QBCore:Notify', src, 'Item has already been used for claiming achievement. Try finding them on your own.', 'warning')
                    return
                end
                if Player.Functions.RemoveItem(configitem, itemamount) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[configitem], 'remove', itemamount)
                    if Player.Functions.AddItem(configitem, itemamount, false, {achievement = true}) then
                        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[configitem], 'add', itemamount)
                    end
                end
            end
        else

        end
        TriggerEvent('bama-achievements:server:CollectReward', src, data.achievement, data.id)
        TriggerClientEvent('QBCore:Notify', src, 'ACHIEVEMENT UNLOCKED!', 'success', 5000)
        if rewardtype == 'cash' or rewardtype == 'bank' then
            reward = '$'..reward
        elseif rewardtype == 'item' then
            reward = QBCore.Shared.Items[reward].label
        else
            reward = 'undefined'
        end
        
        TriggerEvent("qb-log:server:CreateLog", "achievements", "Player Unlocked Achievement", "lastlifeblue", "**Discord:** "..(discord or 'undefined') .."\n**Character Name:** " ..charname.."\n**Unlocked:** "..data.header..'\n**Reward**: '..reward)
    end
end)

RegisterNetEvent('bama-achievements:server:UnlockAchievement', function (data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    local discord = "<@"..QBCore.Functions.GetIdentifier(src, 'discord'):gsub("discord:", "")..">"
    local charname = Player.PlayerData.charinfo.firstname..' '..Player.PlayerData.charinfo.lastname
    local result = MySQL.single.await('SELECT * FROM achievements WHERE license = ? AND achievement = ?', {license, data.achievement})
end)

-- Collect Reward after Unlocking Achievement
RegisterNetEvent('bama-achievements:server:CollectReward', function (source, achievement, id)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local license = QBCore.Functions.GetIdentifier(src, 'license')
    for k, v in pairs(Config.Achievements[id]) do
        if v.achievement == achievement then
            if v.rewardtype == 'cash' or v.rewardtype == 'bank' then
                Player.Functions.AddMoney(v.rewardtype, v.reward)
            elseif v.rewardtype == 'item' then
                if Player.Functions.AddItem(v.reward, v.rewardamount) then
                    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[v.reward], 'add', v.rewardamount)
                end
            end
        end
    end
end)

---------- CALLBACKS ---------------

-- Checks if Achievement Is unlocked(for the menu)
QBCore.Functions.CreateCallback('bama-achievements:server:IsAchievementUnlocked', function (source, cb, achievement)
    local Player = QBCore.Functions.GetPlayer(source)
    local license = QBCore.Functions.GetIdentifier(source, 'license')
    local result = MySQL.query.await('SELECT * FROM achievements WHERE license = ? AND achievement = ?', {license, achievement})
    if result[1] ~= nil then
        cb(result[1])
    else
        cb(false)
    end
end)

QBCore.Commands.Add(Config.Command, 'Open Up Achievements Menu', {}, false, function(source)
    local src = source
    TriggerClientEvent('bama-achievements:client:OpenAchievementMenu', src)
end)


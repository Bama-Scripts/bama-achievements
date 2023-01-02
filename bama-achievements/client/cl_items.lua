QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bama-achievements:client:OpenItemAchievementsMenu', function (data)
    print(data.id)
    local Player = QBCore.Functions.GetPlayerData()
    local itemachievementMenu = {
        {
            header = "<img src="..Config.HeaderImage.." onerror='this.onerror=null; this.remove();'>",
            txt = 'Once you find a certain amount of the below Items, It will unlock and you can claim your reward',
            isMenuHeader = true,
        },
        {
            icon = 'fas fa-circle-xmark',
            header = '', txt = 'Close',
            params = {
                event = '',
            }
        },
        {
            icon = 'fas fa-arrow-left',
            header = '', txt = 'Back',
            params = {
                event = 'bama-achievements:client:OpenAchievementMenu',
            }
        }
    }
    
    for k, v in pairs(Config.Achievements[data.id]) do
        local setheader = v.header..' '..v.amount..' '..QBCore.Shared.Items[v.item].label
        local text = '0/'..v.amount
        QBCore.Functions.TriggerCallback('bama-achievements:server:IsAchievementUnlocked', function (result)
            if result then
                setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050499934568337418/toppng.com-green-check-mark-256x256.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                disable = true
                text = v.amount..'/'..v.amount
            else
                QBCore.Functions.TriggerCallback('bama-achievements:server:GetPlayerItemAmount', function (hasitem)
                    if hasitem.amount >= v.amount then
                        text = v.amount..'/'..v.amount
                    else
                        text = hasitem.amount..'/'..v.amount
                    end
                end, v.item)
                if QBCore.Functions.HasItem(v.item, v.amount) then
                    setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1055198606388383845/5a81af7d9123fa7bcc9b0793.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                    disable = false
                else
                    setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050505748611866714/red-x-mark.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                    disable = true
                end
            end
        end, v.achievement)
        Wait(100)
        itemachievementMenu[#itemachievementMenu+1] = {
            icon = v.item,
            disabled = disable,
            header = setheader,
            txt = text,
            params = {
                isServer = true,
                event = 'bama-achievements:server:UnlockAchievement',
                args = {
                    achievement = v.achievement,
                    Item = v.item,
                    id = data.id,
                    header = setheader
                }
            }
        }
    end
    exports['qb-menu']:openMenu(itemachievementMenu)
end)
QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bama-achievements:client:OpenZombieAchievementsMenu', function (data)
    local Player = QBCore.Functions.GetPlayerData()
    local zombieachievementmenu = {
        {
            header = "<img src="..Config.HeaderImage.." onerror='this.onerror=null; this.remove();'>",
            txt = 'ZOMBIE RELATED ACHIEVEMENTS',
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
    QBCore.Functions.TriggerCallback('bama-achievements:server:GetPlayerZombieKills', function (result)
        for k, v in pairs(Config.Achievements[data.id]) do
            setheader = v.header..' '..v.amount..' Zombies'
            QBCore.Functions.TriggerCallback('bama-achievements:server:IsAchievementUnlocked', function (unlocked)
                if unlocked then
                    setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050499934568337418/toppng.com-green-check-mark-256x256.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                    disable = true
                    text = v.amount..'/'..v.amount
                else
                    if result ~= nil then
                        if result.kills < v.amount then
                            disable = true
                            kills = result.kills
                            setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050505748611866714/red-x-mark.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                            text = result.kills..'/'..v.amount
                        else
                            disable = false
                            kills = v.amount
                            setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1055198606388383845/5a81af7d9123fa7bcc9b0793.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                            text = v.amount..'/'..v.amount
                        end
                    else
                        kills = 0
                        disable = true
                    end
                end
            end, v.achievement)
            Wait(100)
            zombieachievementmenu[#zombieachievementmenu+1] = {
                icon = 'fa-solid fa-gun',
                disabled = disable,
                header = setheader,
                txt = text,
                params = {
                    isServer = true,
                    event = 'bama-achievements:server:UnlockAchievement',
                    args = {
                        achievement = v.achievement,
                        id = data.id,
                        header = setheader
                    }
                }
            }
        end
        exports['qb-menu']:openMenu(zombieachievementmenu)
    end)
end)
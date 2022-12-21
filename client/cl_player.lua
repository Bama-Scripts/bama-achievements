QBCore = exports['qb-core']:GetCoreObject()



-------------------------------------------------------
---------CURRENTLY NOT AVAILABLE-----------------------
-------------------------------------------------------

RegisterNetEvent('bama-achievements:client:OpenPlayerAchievementsMenu', function (data)
    local Player = QBCore.Functions.GetPlayerData()
    local playerachievementmenu = {
        {
            header = "<img src="..Config.HeaderImage.." onerror='this.onerror=null; this.remove();'>",
            txt = 'PLAYER RELATED ACHIEVEMENTS - For Death Achievements: Must Die by Another Player',
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
    QBCore.Functions.TriggerCallback('bama-achievements:server:GetPlayerKD', function (result)
        for k, v in pairs(Config.Achievements[data.id]) do
            if v.header == 'Kill ' then
                setheader = v.header..' '..v.amount..' Players'
                if result.kills ~= nil then
                    QBCore.Functions.TriggerCallback('bama-achievements:server:IsAchievementUnlocked', function (unlocked)
                        if unlocked then
                            setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050499934568337418/toppng.com-green-check-mark-256x256.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                            disable = true
                            text = v.amount..'/'..v.amount
                        else
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
                        end
                    end, v.achievement)
                    
                else
                    disable = true
                    kills = 0
                end
                Wait(100)
                playerachievementmenu[#playerachievementmenu+1] = {
                    icon = "fa-solid fa-shield-halved",
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
            elseif v.header == 'Die ' then
                setheader = v.header..' '..v.amount..' Times'
                QBCore.Functions.TriggerCallback('bama-achievements:server:IsAchievementUnlocked', function (unlocked)
                    if unlocked then
                        setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050499934568337418/toppng.com-green-check-mark-256x256.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                        disable = true
                        text = v.amount..'/'..v.amount
                    else
                        if result.deaths < v.amount then
                            disable = true
                            deaths = result.deaths
                            setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1050505748611866714/red-x-mark.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                            text = result.deaths..'/'..v.amount
                        else
                            disable = false
                            kills = v.amount
                            setheader = "<img src=https://cdn.discordapp.com/attachments/1016036231534084168/1055198606388383845/5a81af7d9123fa7bcc9b0793.png width=30px onerror='this.onerror=null; this.remove();'>"..setheader
                            text = v.amount..'/'..v.amount
                        end
                    end
                end, v.achievement)
                Wait(100)
                playerachievementmenu[#playerachievementmenu+1] = {
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
        end
        exports['qb-menu']:openMenu(playerachievementmenu)
    end)
end)

local alreadyDead = false
CreateThread(function()
	while true do
		local myPed = GetPlayerPed(-1)

		if IsEntityDead(myPed) and not alreadyDead then
			local killerPed = GetPedSourceOfDeath(myPed)

			if IsEntityAPed(killerPed) and IsPedAPlayer(killerPed) then
				local player = NetworkGetPlayerIndexFromPed(killerPed)
				local sourceKiller = GetPlayerServerId(player)
				
				TriggerServerEvent('bama-achievements:server:UpdateBoard', sourceKiller)
				alreadyDead = true
			end
		end
		if not IsEntityDead(myPed) then
			alreadyDead = false
		end

		Wait(0)
	end
end)
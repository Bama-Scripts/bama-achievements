QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('bama-achievements:client:OpenAchievementMenu', function ()
    local achievementMenu = {
        {
            header = "<img src="..Config.HeaderImage.." onerror='this.onerror=null; this.remove();'>",
            isMenuHeader = true,
        },
        {
            icon = 'fas fa-circle-xmark',
            header = '', txt = 'Close',
            params = {
                event = '',
            }
        },
    }
    if Config.UseItemAchievments then
        achievementMenu[#achievementMenu+1] = {
            icon = 'fas fa-sitemap',
            header = 'Item Achievements',
            txt = '',
            params = {
                event = 'bama-achievements:client:OpenItemAchievementsMenu',
                args = {
                    id = 1
                }
            },
        }
    end
    if Config.UsePlayerAchievements then
        achievementMenu[#achievementMenu+1] = {
            icon = 'fas fa-person',
            header = 'Player Achievements',
            params = {
                event = 'bama-achievements:client:OpenPlayerAchievementsMenu',
                args = {
                    id = 2
                }
            },
        }
    end
    if Config.UseZombieAchievements then
        achievementMenu[#achievementMenu+1] = {
            icon = 'fas fa-biohazard',
            header = 'Zombie Achievements',
            params = {
                event = 'bama-achievements:client:OpenZombieAchievementsMenu',
                args = {
                    id = 3
                },
            },
        }
    end
    exports['qb-menu']:openMenu(achievementMenu)
end)
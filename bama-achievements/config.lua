Config = {}
Config.Debug = false                -- Will be implemented for debugging issues
Config.UseWebhook = true            -- If Config.UseWebhook = true then Create "achievements" webhook in qb-smallresources/server/logs.lua then paste the webhook there.
Config.AllowPlayerExchange = false  -- Allow Players to give players their items after using for their achievement (true|false)
Config.HeaderImage = 'https://cdn.discordapp.com/attachments/1016036231534084168/1051240440629829833/lastlifeachievements-smaller.png' -- Image to put as the header for the menu. Image Must Be no bigger than 250x50

---- NOT IMPLEMENTED YET
Config.UnlockedImage = 'unlocked.png'   -- This shows when when a player has Unlocked the achievement
Config.LockedImage = 'locked.png'       -- This shows when a player hasn't unlocked the achievement
Config.ClaimImage = 'claim.png'         -- This shows when a player has a Achievement to claim
Config.UseCommand = false               -- Use Command?
Config.UseKeyBind = false               -- Use Keybind?
Config.UseTarget = false                -- Use Location for players to check?
-------------------------

Config.Command = 'achievements'         -- Command to use to open them achievements menu

Config.UseItemAchievments = true       -- Will add/remove option in the menu
Config.UsePlayerAchievements = true    -- Will add/remove option in the menu
Config.UseZombieAchievements = true    -- WIll add/remove option in the menu

local Item = {
    ['find_blackmarketkey'] = {                 -- must be the same as achievement so it can be placed in database correctly.
        header = 'Find',                        -- Menu Selection Header
        achievement = 'find_blackmarketkey',    -- Will be what goes into database to look for if it's already been unlocked or not
        item = 'blackmarketkey',                -- Item You Must have to unlock achievement
        amount = 1,                             -- Amount of above item you must have to unlock achievement
        rewardtype = 'cash',                    -- Reward Type (can be: 'bank', 'cash', 'item')
        reward = 5000                           -- If rewardtype == 'cash/bank' then will be what is given. If rewardtype == 'item' then will be the item given.
    },
    ['find_copperore'] = {
        header = 'Find',
        achievement = 'find_copperore',
        item = 'copperore',
        amount = 100,
        rewardtype = 'item',
        reward = 'nightgoggles',
        rewardamount = 1
    },
    ['find_exhaust'] = {
        header = 'Find',
        achievement = 'find_exhaust',
        item = 'exhaust',
        amount = 10,
        rewardtype = 'cash',
        reward = 2000,
    },
    ['find_nos'] = {
        header = 'Find',
        achievement = 'find_nos',
        item = 'nos',
        amount = 1,
        rewardtype = 'cash',
        reward = 1000
    },
    ['find_diamond'] = {
        header = 'Find',
        achievement = 'find_diamond',
        item = 'diamond',
        amount = 5,
        rewardtype = 'cash',
        reward = 2000
    },
    ['find_thermite'] = {
        header = 'Find',
        achievement = 'find_thermite',
        item = 'thermite',
        amount = 10,
        rewardtype = 'cash',
        reward = 5000,
    },
    ['find_trojan_usb'] = {
        header = 'Find',
        achievement = 'find_trojan_usb',
        item = 'trojan_usb',
        amount = 5,
        rewardtype = 'cash',
        reward = 5000
    }
}
local Player = {
    ['player_kill_1'] = {
        header = 'Kill ',
        achievement = 'player_kill_1',
        amount = 1,
        rewardtype = 'cash',
        reward = 500
    },
    ['player_kill_10'] = {
        header = 'Kill ',
        achievement = 'player_kill_10',
        amount = 10,
        rewardtype = 'cash',
        reward = 750
    },
    ['player_kill_30'] = {
        header = 'Kill ',
        achievement = 'player_kill_30',
        amount = 30,
        rewardtype = 'cash',
        reward = 1000
    },
    ['player_die_1'] = {
        header = 'Die ',
        achievement = 'player_die_1',
        amount = 1,
        rewardtype = 'cash',
        reward = 100
    },
    ['player_die_10'] = {
        header = 'Die ',
        achievement = 'player_die_10',
        amount = 10,
        rewardtype = 'cash',
        reward = 200,
    },
    ['player_die_50'] = {
        header = 'Die ',
        achievement = 'player_die_50',
        amount = 50,
        rewardtype = 'cash',
        reward = 500
    }
}
local Zombie = {
    ['zombie_kill_50'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_50',
        amount = 50,
        rewardtype = 'cash',
        reward = 1000
    },
    ['zombie_kill_100'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_100',
        amount = 100,
        rewardtype = 'cash',
        reward = 1200
    },
    ['zombie_kill_1000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_1000',
        amount = 1000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_1500'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_1500',
        amount = 1500,
        rewardtype = 'cash',
        reward = 2100
    },
    ['zombie_kill_2000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_2000',
        amount = 2000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_3000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_3000',
        amount = 3000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_4000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_4000',
        amount = 4000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_5000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_5000',
        amount = 5000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_10000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_10000',
        amount = 10000,
        rewardtype = 'cash',
        reward = 2000
    },
    ['zombie_kill_20000'] = {
        header = 'Kill ',
        achievement = 'zombie_kill_20000',
        amount = 20000,
        rewardtype = 'cash',
        reward = 2000
    },
}

Config.Achievements = {         -- DO NOT TOUCH USE CONFIG.USEXACHIEVEMENT ABOVE
    Item,
    Player,
    Zombie,
}
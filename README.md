# Bama Achievments
This is an Achievement Script for QBCore Framework, where players can Unlock Achievements for certain stuff.

##  Current Available Achievements:
### Item Related Achievements:
- Able to Find X amount of a certain Item

### Player Related Achievements:
- Player Kills - will unlock when they reach X amount of kills(specified in the config) of other players(Automatically triggers and gets saved to the database)
- Player Deaths - will unlock when a player reaches X amount of Deaths(specified in the config)(Automatically triggers and gets saved to the database)

### Zombie Related Achievements: - For those that have a Zombie Server Like Myself.
- Kill X Zombies - will unlock when they reach X amount of zombie kills(specified in the config)(Trigger Event must be added to the Event that Triggers when a player kills a zombie.

## UPCOMING Achievements:
### Secert Achievements: 
- Will most likely get added to each category so you can have a specific Item to be found but you don't want players to know which Item it is.(WIll unlock when they have the specific item in their inventory.)

### Collectible Achievements:
- WIll have a link to another script or 2 where they have to find a specific Set of collectibles. Like the pokemon cards or some action figures.

### Unlock All Achievments:
- Will be available to unlock once all other achievements have been unlocked.

# Dependencies
qb-menu - For the Menus

# How to Install
- Place in your resource folder
- Add ```ensure bama-achievements``` to your server.cfg

### If you want to use The Zombie Related Achievements then Place the following code whereever your zombie script looks for Player Killing the Zombie:
```
local ped = PlayerPedId()
local killerPed = GetPedSourceOfDeath(yourpedvariable)
local player = NetWorkGetPlayerIndexFromPed(killerPed)
local sourceKiller = GetPlayerServerId(player)
if killerPed == ped then
  TriggerServerEvent('bama-achievements:server:ZombieKill', sourceKiller)
end
```

# **Video Previews**
*Coming Soon*
# Picture Previews
![alt text](https://cdn.discordapp.com/attachments/1055235866232107078/1055235908892360814/Screenshot_521.png)
![alt text](https://cdn.discordapp.com/attachments/1055235866232107078/1055235908540047481/Screenshot_520.png)
#
![alt text](https://cdn.discordapp.com/attachments/1055235866232107078/1055235908158357614/Screenshot_519.png)
![alt text](https://cdn.discordapp.com/attachments/1055235866232107078/1055235907793461259/Screenshot_517.png)

# Custom Images
### Image For Header(Customizable in the Config)
![alt text](https://cdn.discordapp.com/attachments/1016036231534084168/1051240440629829833/lastlifeachievements-smaller.png)

### Image For Achievement Locked
![alt text](https://cdn.discordapp.com/attachments/1016036231534084168/1055232964046376980/red-x-mark.png)

### Image For Achievement Unlocked but not Claimed
![alt text](https://cdn.discordapp.com/attachments/1016036231534084168/1055232512282075178/5a81af7d9123fa7bcc9b0793.png)

### Image For Achievement Unlocked and Claimed
![alt text](https://cdn.discordapp.com/attachments/1016036231534084168/1055232963668873246/toppng.com-green-check-mark-256x256.png)

#Shoutouts
hugo.simoes.12345 - For the zombie zombie script. He has done a really awesome job on it.
Man1C - For helping with a few small details
Tony - For helping with a few small details

# Links
- Zombie Script
  - Discord: https://discord.gg/hrsscripts
  - Script: https://hrs-scripts.tebex.io/package/5347766
  - I also recommend the Loot Script that goes with the zombies: https://hrs-scripts.tebex.io/package/5347769
  - To get both as a package: https://hrs-scripts.tebex.io/package/5347761
**If you have this script, I will have a snippet in his discord for how to insert the event for the achievement**

* Bama Scripts
  - Discord: https://discord.gg/cKtyJFsQNS

# OTHER STUFF
If you have any questions please do not hesitate to ask.

I will take all recommendations for the script into consideration and if you already have it done and would like to contribute to the script, then please create a PR and I will look at it and approve it. As well as, there will be a Snippets channel in the discor

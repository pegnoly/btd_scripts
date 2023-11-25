consoleCmd('console_size 10000')
doFile('/scripts/source/3rdparty/lualib.lua')
doFile("/scripts/source/common/global/consts.lua")
doFile("/scripts/source/common/adv_map/consts.lua")
doFile("/scripts/source/common/random.lua")
sleep()
doFile("/scripts/source/entity/creature/abils.lua")
doFile("/scripts/source/entity/creature/consts.lua")
doFile("/scripts/source/entity/artifact/consts.lua")
doFile("/scripts/source/entity/hero/consts.lua")
doFile("/scripts/source/entity/spell/consts.lua")
sleep()
while not HERO_SPEC_NONE and TOWN_NO_TYPE do
	sleep()
end
doFile('/scripts/generated/creatures.lua')
doFile('/scripts/generated/heroes.lua')
doFile('/scripts/generated/artifacts.lua')
doFile('/scripts/generated/spells.lua')
sleep()
doFile('/scripts/source/common/adv_map/override.lua')
doFile('/scripts/source/common/adv_map/load.lua')
doFile('/scripts/source/event/map_common/events.lua')
doFile('/scripts/source/event/custom_ability/custom_ability_main.lua')
sleep()
doFile('/scripts/source/entity/object.lua')
doFile('/scripts/source/entity/resource.lua')
doFile("/scripts/source/entity/load.lua")
sleep()
doFile('/scripts/source/quest/quest.lua')
doFile('/scripts/source/dialog/dialog.lua')
doFile('/scripts/source/dialog/mini_dialog.lua')
doFile('/scripts/source/event/touch/touch.lua')
doFile('/scripts/source/event/map_common/events.lua')

while not MapLoadingEvent do 
	sleep()
end
startThread(Creature.Sorting.Init)
startThread(Art.Distribution.Init)
doFile("/scripts/global_load.lua")

MCCS_FIRST_ACTIVE_PLAYER = -1

for player = PLAYER_1, PLAYER_8 do
  if GetPlayerState(player) == PLAYER_ACTIVE then
    MCCS_FIRST_ACTIVE_PLAYER = player
    break
  end
end

Trigger(OBJECTIVE_STATE_CHANGE_TRIGGER, 'HIDDEN', MCCS_FIRST_ACTIVE_PLAYER, 'CommonStart')

GAME_RELOADEAD = 1

--doFile('/scripts/NAF/global_load.lua')
doFile('/scripts/source/event/map_common/post_combat_fix.lua')
doFile('/scripts/source/event/map_common/map_reload_fix.lua')
--doFile('/scripts/NHF_global_load.lua')

function CommonStart()
  consoleCmd("@GAME_RELOADEAD = 0")
	doFile("/scripts/local_load.lua")
	sleep()
	startThread(CommonMapLoadingThread)
	print("<color=blue>MCCS SCRIPTS SUCCESSFULLY LOADED")
end

function CommonMapLoadingThread()
  --
 	for player = PLAYER_1, PLAYER_8 do
     startThread(MessageQueue.Run, player)
  end
  --
  NewDayEvent.AddListener('MCCS_ai_gold_fix_event',
  function(day)
    for player = PLAYER_1, PLAYER_8 do
      if GetPlayerState(player) == PLAYER_ACTIVE and (IsAIPlayer(player) == 1) then
        SetPlayerResource(player, GOLD, 100000000)
        print("Gold fix applied to player ", player)
      end
    end
  end)
  --
  MapLoadingEvent.Invoke()
  startThread(CustomAbility.Init)
  --
  sleep(10)
  --
  startThread(AdvMapThreads.AddHeroesThread)
  startThread(AdvMapThreads.RemoveHeroesThread)
  startThread(AdvMapThreads.CombatResultsThread)
  startThread(AdvMapThreads.NewDayThread)
  startThread(PostCombatFixInit)
  --
  sleep()
  CombatConnection.CreateCombatFunctionsList(CombatConnection.combat_scripts_paths)
end

function ReloadGame()
    consoleCmd("@if GAME_RELOADEAD == 1 then startThread(MapReloadEvent.Invoke) else print('Game was not realoaded') end")
end

function GameReloaded()
    print("Game was reloaded?")
    startThread(MapReloadEvent.Invoke)
end

consoleCmd(
  "@if GetObjectiveState('HIDDEN', MCCS_FIRST_ACTIVE_PLAYER) == OBJECTIVE_UNKNOWN then SetObjectiveState('HIDDEN', OBJECTIVE_ACTIVE, MCCS_FIRST_ACTIVE_PLAYER) else sleep(2) ReloadGame() end"
)

--SetObjectiveState('HIDDEN', OBJECTIVE_ACTIVE, MCCS_FIRST_ACTIVE_PLAYER)
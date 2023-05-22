function Calibrate()
  local hero_p1 = GetPlayerHeroes(PLAYER_1)[0]
  local hero_p2 = GetPlayerHeroes(PLAYER_2)[0]
  consoleCmd("@SetGameVar('"..hero_p1.."_CALIBRATION_FIGHT', '1')")
  consoleCmd("@SetGameVar('"..hero_p2.."_CALIBRATION_FIGHT', '1')")
  startThread(StartCombat, hero_p1, nil, 1, 1, 1)
  startThread(StartCombat, hero_p2, nil, 1, 1, 1)
end

NewDayEvent.AddListener('btd_duel_init_arena_fight_event',
function(day)
  if day == BTD_FIGHT_DAY then
    Calibrate()
    sleep(20)
    --
    local magic_well = GetObjectNamesByType("BUILDING_MAGIC_WELL")[0]
    local p1_hero = GetPlayerHeroes(PLAYER_1)[0]
    local p1_town = GetHeroTown(p1_hero)
    if p1_town then
      p1_hero = GetTownHero(p1_town)
    end
    SetObjectPosition(p1_hero, RegionToPoint("p1_spawn"))
    ChangeHeroStat(p1_hero, STAT_MANA_POINTS, -GetHeroStat(p1_hero, STAT_MANA_POINTS))
    MakeHeroInteractWithObject(p1_hero, magic_well)
    --
    local p2_hero = GetPlayerHeroes(PLAYER_2)[0]
    local p2_town = GetHeroTown(p2_hero)
    if p2_town then
      p2_hero = GetTownHero(p2_town)
    end
    SetObjectPosition(p2_hero, RegionToPoint("sp_"..random(16) + 1))
    ChangeHeroStat(p2_hero, STAT_MANA_POINTS, -GetHeroStat(p2_hero, STAT_MANA_POINTS))
    MakeHeroInteractWithObject(p2_hero, magic_well)
    --
    OpenRegionFog(PLAYER_1, "BattlefieldFog")
    OpenRegionFog(PLAYER_2, "BattlefieldFog")
    --
    Trigger(PLAYER_REMOVE_HERO_TRIGGER, PLAYER_1, 'HeroDefeated')
    Trigger(PLAYER_REMOVE_HERO_TRIGGER, PLAYER_2, 'HeroDefeated')
  end
end)

function HeroDefeated(hero, killer)
  if killer then
    _winner = GetObjectOwner(killer)
    startThread(MCCS_MessageBoxForPlayers, _winner, GetMapDataPath().."UHaveWon.txt", 'Win_('.._winner..')')
  end
end


function Win_(pl)
  SetObjectiveState("MainObjective", OBJECTIVE_COMPLETED, pl)
  return parse ''
end
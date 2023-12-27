function Calibrate(hero)
  StartCombat(hero, nil, 1, 1, 1, "/CombatThreadReloadScript.xdb#xpointer(/Script)")
  --StartCombat(hero_p2, nil, 1, 1, 1, "/CombatThreadReloadScript.xdb#xpointer(/Script)")
end

NewDayEvent.AddListener('btd_duel_init_arena_fight_event',
function(day)
  if day == BTD_duel_day_sequence.prefight_day then
    --
    local magic_well = GetObjectNamesByType("BUILDING_MAGIC_WELL")[0]
    startThread(
    function ()
        local p1_hero = GetPlayerHeroes(PLAYER_1)[0]
        local p1_town = GetHeroTown(p1_hero)
        if p1_town then
          p1_hero = GetTownHero(p1_town)
        end
        SetObjectPosition(p1_hero, RegionToPoint("p1_spawn"))
        Touch.DisableHero(p1_hero)
        btd_duel_free_roam.free_roam_active_for_hero[p1_hero] = 1
        ChangeHeroStat(p1_hero, STAT_MANA_POINTS, -GetHeroStat(p1_hero, STAT_MANA_POINTS))
        MakeHeroInteractWithObject(p1_hero, %magic_well)
        for i, shrine in {'Shrine1_1','Shrine1_2','Shrine1_3','Shrine1_4','Shrine1_5','Shrine1_6'} do
            MakeHeroInteractWithObject(p1_hero, shrine)
        end
    end)
    --
    startThread(
    function ()
        local p2_hero = GetPlayerHeroes(PLAYER_2)[0]
        local p2_town = GetHeroTown(p2_hero)
        if p2_town then
          p2_hero = GetTownHero(p2_town)
        end
        SetObjectPosition(p2_hero, RegionToPoint("sp_"..random(16) + 1))
        Touch.DisableHero(p2_hero)
        btd_duel_free_roam.free_roam_active_for_hero[p2_hero] = 1
        ChangeHeroStat(p2_hero, STAT_MANA_POINTS, -GetHeroStat(p2_hero, STAT_MANA_POINTS))
        MakeHeroInteractWithObject(p2_hero, %magic_well)
        for i, shrine in {'Shrine2_1','Shrine2_2','Shrine2_3','Shrine2_4','Shrine2_5','Shrine2_6'} do
            MakeHeroInteractWithObject(p2_hero, shrine)
        end
    end)
    --
    OpenRegionFog(PLAYER_1, "BattlefieldFog")
    OpenRegionFog(PLAYER_2, "BattlefieldFog")
    --
    Trigger(PLAYER_REMOVE_HERO_TRIGGER, PLAYER_1, 'HeroDefeated')
    Trigger(PLAYER_REMOVE_HERO_TRIGGER, PLAYER_2, 'HeroDefeated')
    -- 
    for player = PLAYER_1, PLAYER_2 do
        startThread(MCCS_MessageBoxForPlayers, player, "/scripts/Duel/advmap/DaySequence/Prefight/select_arena.txt")
    end
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
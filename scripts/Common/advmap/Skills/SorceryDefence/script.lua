sorcery_def =
{
  active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_sorcery_def_add_hero_event",
function(hero)
  sorcery_def.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not sorcery_def.active_for_hero[%hero] then
          if HasHeroSkill(%hero, 221) then
            sorcery_def.active_for_hero[%hero] = 1
            consoleCmd("@SetGameVar('"..%hero.."MAG_DEF', '1')")
          end
        else
          if not HasHeroSkill(%hero, 221) then
            sorcery_def.active_for_hero[%hero] = nil
            consoleCmd("@SetGameVar('"..%hero.."MAG_DEF', '')")
          end
        end
      end
      sleep()
    end
  end)
end)

RespawnHeroEvent.AddListener("BTD_common_sorcery_defence_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, 221) then
        consoleCmd("@SetGameVar('"..hero.."MAG_DEF', '1')")
    end   
end)
path_of_war_duel =
{
    attack_bonus = 3,
    heroes_active = {}
}

AddHeroEvent.AddListener("btd_duel_path_of_war_add_hero_listener",
function(hero)
  errorHook(function ()
      print("<color=red>Error: <color=green> PathOfWar duel add hero.")
  end)
  path_of_war_duel.heroes_active[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not path_of_war_duel.heroes_active[%hero] then
          if HasHeroSkill(%hero, HERO_SKILL_PATH_OF_WAR) then
            path_of_war_duel.heroes_active[%hero] = 1
            ChangeHeroStat(%hero, STAT_ATTACK, path_of_war_duel.attack_bonus)
          end
        else
          if not HasHeroSkill(%hero, HERO_SKILL_PATH_OF_WAR) then
            path_of_war_duel.heroes_active[%hero] = nil
            ChangeHeroStat(%hero, STAT_ATTACK, -path_of_war_duel.attack_bonus)
          end
        end
      end
      sleep()
    end
  end)
end)
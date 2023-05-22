war_path =
{
  attack_bonus = 3,
  heroes_active = {}
}

AddHeroEvent.AddListener("war_path_add_hero_event",
function(hero)
  war_path.heroes_active[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not war_path.heroes_active[%hero] then
          if HasHeroSkill(%hero, HERO_SKILL_PATH_OF_WAR) then
            war_path.heroes_active[%hero] = 1
            ChangeHeroStat(%hero, STAT_ATTACK, war_path.attack_bonus)
          end
        else
          if not HasHeroSkill(%hero, HERO_SKILL_PATH_OF_WAR) then
            war_path.heroes_active[%hero] = nil
            ChangeHeroStat(%hero, STAT_ATTACK, -war_path.attack_bonus)
          end
        end
      end
      sleep()
    end
  end)
end)
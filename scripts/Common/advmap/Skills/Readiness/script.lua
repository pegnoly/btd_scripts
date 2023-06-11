readiness =
{
  active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_readiness_add_hero_event",
function(hero)
  readiness.active_for_hero[hero] = nil
  startThread(
  function()
    while 1 do
      if IsHeroAlive(%hero) then
        if not readiness.active_for_hero[%hero] then
          if HasHeroSkill(%hero, HERO_SKILL_PREPARATION) then
            readiness.active_for_hero[%hero] = 1
            consoleCmd("@SetGameVar('"..%hero.."_MASTERY_READY', '1')")
          end
        else
          if not HasHeroSkill(%hero, HERO_SKILL_PREPARATION) then
            readiness.active_for_hero[%hero] = nil
            consoleCmd("@SetGameVar('"..%hero.."_MASTERY_READY', '')")
          end
        end
      end
      sleep()
    end
  end)
end)
necromancy =
{
  [2] = {[1] = 30, [2] = 20, [3] = 10},
  [3] = {[1] = 60, [2] = 40, [3] = 20},
  [4] = {[1] = 100, [2] = 70, [3] = 40}
}

NewDayEvent.AddListener("necromancy_new_day",
function(day)
  if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, SKILL_NECROMANCY) then
                local mastery = GetHeroSkillMastery(hero, SKILL_NECROMANCY)
                if necromancy[mastery] then
                    for tier = 1, 3 do
                        startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, tier, necromancy[mastery][tier])
                    end
                end
            end
        end
    end
end)
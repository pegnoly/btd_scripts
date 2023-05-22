runelore =
{
  [1] = {[0] = 3, [1] = 3, [2] = 0, [3] = 0, [4] = 0, [5] = 0},
  [2] = {[0] = 6, [1] = 6, [2] = 2, [3] = 2, [4] = 2, [5] = 2},
  [3] = {[0] = 9, [1] = 9, [2] = 4, [3] = 4, [4] = 4, [5] = 4},
  [4] = {[0] = 9, [1] = 9, [2] = 4, [3] = 4, [4] = 4, [5] = 4}
}

NewDayEvent.AddListener("runelore_new_day",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, HERO_SKILL_RUNELORE) then
                local mastery = GetHeroSkillMastery(hero, HERO_SKILL_RUNELORE)
                if runelore[mastery] then
                    for res = WOOD, GEM do
                        if runelore[mastery][res] ~= 0 then
                            startThread(Resource.Change, hero, res, runelore[mastery][res])
                        end
                    end
                end
            end
        end
    end
end)
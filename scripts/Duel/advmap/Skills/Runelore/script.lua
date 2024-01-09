runelore =
{
    [1] = {[0] = 3, [1] = 3, [2] = 0, [3] = 0, [4] = 0, [5] = 0},
    [2] = {[0] = 6, [1] = 6, [2] = 2, [3] = 2, [4] = 2, [5] = 2},
    [3] = {[0] = 9, [1] = 9, [2] = 4, [3] = 4, [4] = 4, [5] = 4},
    [4] = {[0] = 9, [1] = 9, [2] = 6, [3] = 6, [4] = 6, [5] = 6}
}

NewDayEvent.AddListener("runelore_new_day",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, HERO_SKILL_RUNELORE) then
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
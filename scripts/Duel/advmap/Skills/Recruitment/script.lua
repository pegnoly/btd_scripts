recruitment_duel =
{
}

NewDayEvent.AddListener("btd_duel_recruitment_new_day_listener",
function(day)
    errorHook(function ()
        print("<color=red>Error: <color=green> Recruitment duel new day.")
    end)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_RECRUITMENT) then
                local race = Hero.Params.Town(hero)
                for tier = 1, 3 do
                    local grow = Creature.Params.Grow(TIER_TABLES[race][tier][1])
                    startThread(Hero.CreatureInfo.DefaultGrow, hero, race, tier, grow)
                end
            end
        end
    end
end)
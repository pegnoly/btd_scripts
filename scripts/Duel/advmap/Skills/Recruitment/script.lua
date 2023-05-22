recruitment =
{
}

NewDayEvent.AddListener("recruitment_new_day",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.a do
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
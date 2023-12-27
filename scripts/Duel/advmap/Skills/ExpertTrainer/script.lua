expert_trainer_duel =
{
    peasant_grow = 85, 
}

NewDayEvent.AddListener("btd_duel_expert_trainer_new_day",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_EXPERT_TRAINER) then
                startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_HEAVEN, 1, expert_trainer_duel.peasant_grow)
            end
        end
    end
end)

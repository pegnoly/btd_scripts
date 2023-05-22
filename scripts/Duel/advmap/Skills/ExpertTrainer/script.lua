expert_trainer =
{
    peasant_grow = 85, 
}

NewDayEvent.AddListener("expert_trainer_new_day",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_EXPERT_TRAINER) then
                startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_HEAVEN, 1, expert_trainer.peasant_grow)
            end
        end
    end
end)

goblin_support_duel =
{
    goblin_grow = 150, 
}

NewDayEvent.AddListener("goblin_support_add_hero_event",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, HERO_SKILL_GOBLIN_SUPPORT) then
                startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_STRONGHOLD, 1, goblin_support_duel.goblin_grow)
            end
        end
    end
end)
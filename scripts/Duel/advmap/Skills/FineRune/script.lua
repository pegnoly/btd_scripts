--- 25.05.2023 - moved from duel file to common file, improved for new events system.

fine_rune_duel = 
{
    res_amount = 3
}

NewDayEvent.AddListener("BTD_duel_fine_rune_new_day",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if alive and HasHeroSkill(hero, HERO_SKILL_FINE_RUNE) then
                for res = WOOD, GEM do
                    Resource.Change(hero, res, fine_rune_duel.res_amount)
                end
            end
        end
    end
end)
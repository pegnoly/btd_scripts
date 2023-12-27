ornella_spec_duel =
{
    heroes = {"Ornella1", "Ornella2"}, 
    speed_amount = 1
}

NewDayEvent.AddListener('NHF_ornella_new_day_event',
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(ornella_spec_duel.heroes, hero) then
                GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_SPEED, ornella_spec_duel.speed_amount)
            end
        end
    end
end)
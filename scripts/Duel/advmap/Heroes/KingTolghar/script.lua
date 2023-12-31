tolghar_spec_duel = {
    hp_percent = 0.5,
    heroes = {"KingTolghar1", "KingTolghar2"}
}

NewDayEvent.AddListener("btd_duel_tolghar_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(tolghar_spec_duel.heroes, hero) then
                GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_HITPOINTS, GetHeroLevel(hero) * tolghar_spec_duel.hp_percent)
            end
        end
    end
end)
--- 26.05.2023. Improved and moved.

road_home_duel =
{
    speed_bonus = 1 -- число скорости, которое дает перк
}

NewDayEvent.AddListener("BTD_duel_road_home_new_day_listener",
function(day)
    errorHook(function ()
        print("<color=red>Error: <color=green> RoadHome duel new day.")
    end)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, KNIGHT_FEAT_ROAD_HOME) then
                GiveHeroBattleBonus(hero, HERO_BATTLE_BONUS_SPEED, road_home_duel.speed_bonus)
            end
        end
    end
end)
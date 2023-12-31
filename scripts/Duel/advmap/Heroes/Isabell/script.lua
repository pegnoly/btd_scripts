isabell_spec_rmg = {
    heroes = {"Isabell1", "Isabell2"}
}

NewDayEvent.AddListener("btd_duel_isabell_spec_new_day",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(isabell_spec_rmg.heroes, hero) then
                local player = GetObjectOwner(hero)
                UpgradeTownBuilding(Player.GetTowns(player)[1], TOWN_BUILDING_HAVEN_MONUMENT_TO_FALLEN_HEROES)
            end
        end
    end
end)
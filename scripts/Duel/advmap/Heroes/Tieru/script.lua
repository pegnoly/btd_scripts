tieru_spec_duel = {
    heroes = {"Tieru1", "Tieru2"}
}

AddHeroEvent.AddListener("btd_duel_tieru_add_hero_listener",
function(hero)
    if contains(tieru_spec_duel.heroes, hero) then
        while not BTD_Duel_ArmyDistribution.custom_add_func[hero] do
            sleep()
        end
        BTD_Duel_ArmyDistribution.custom_add_func[hero][4] = function()
            startThread(Hero.CreatureInfo.Add, %hero, 801, random(6) + 33)
        end
    end
end)

NewDayEvent.AddListener("btd_duel_tieru_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(tieru_spec_duel.heroes, hero) then
                local avenger = "avenger_"..(3 - GetObjectOwner(hero))
                local count = GetObjectCreatures(avenger, CREATURE_DRUID)
                RemoveObjectCreatures(avenger, CREATURE_DRUID, count)
                while GetObjectCreatures(avenger, CREATURE_DRUID) > 0 do
                    sleep()
                end
                AddObjectCreatures(avenger, 801, count)
            end
        end
    end
end)
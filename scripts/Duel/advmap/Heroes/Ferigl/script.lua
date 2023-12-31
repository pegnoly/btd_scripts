ferigl_spec_duel = {
    heroes = {"Ferigl1", "Ferigl2"}
}

AddHeroEvent.AddListener("btd_duel_ferigl_add_hero_listener",
function(hero)
    if contains(ferigl_spec_duel.heroes, hero) then
        while not BTD_Duel_ArmyDistribution.custom_add_func[hero] do
            sleep()
        end
        BTD_Duel_ArmyDistribution.custom_add_func[hero][4] = function()
            startThread(Hero.CreatureInfo.Add, %hero, 939, random(8) + 33)
        end
    end
end)

NewDayEvent.AddListener("btd_duel_ferigl_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(ferigl_spec_duel.heroes, hero) then
                local avenger = "avenger_"..(3 - GetObjectOwner(hero))
                local count = GetObjectCreatures(avenger, CREATURE_RIDER)
                RemoveObjectCreatures(avenger, CREATURE_RIDER, count)
                while GetObjectCreatures(avenger, CREATURE_RIDER) > 0 do
                    sleep()
                end
                AddObjectCreatures(avenger, 939, count)
            end
        end
    end
end)
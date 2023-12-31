tan_spec_duel = {
    heroes = {"Tan1", "Tan2"}
}

AddHeroEvent.AddListener("btd_duel_tan_add_hero_listener",
function(hero)
    if contains(tan_spec_duel.heroes, hero) then
        while not BTD_Duel_ArmyDistribution.custom_add_func[hero] do
            sleep()
        end
        BTD_Duel_ArmyDistribution.custom_add_func[hero][4] = function()
            startThread(Hero.CreatureInfo.Add, %hero, 949, random(10) + 27)
        end
    end
end)

NewDayEvent.AddListener("btd_duel_tan_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and contains(tan_spec_duel.heroes, hero) then
                local avenger = "avenger_"..(3 - GetObjectOwner(hero))
                local count = GetObjectCreatures(avenger, CREATURE_GENIE)
                RemoveObjectCreatures(avenger, CREATURE_GENIE, count)
                while GetObjectCreatures(avenger, CREATURE_GENIE) > 0 do
                    sleep()
                end
                AddObjectCreatures(avenger, 949, count)
            end
        end
    end
end)
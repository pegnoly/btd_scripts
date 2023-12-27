wulfstan_spec_duel = {
    heroes = {"Wulfstan1", "Wulfstan2"},
    offence_divisor = 4
}

AddHeroEvent.AddListener("btd_duel_wulfstan_add_hero_listener",
function(hero)
    if contains(wulfstan_spec_duel.heroes, hero) then
        while not BTD_Duel_ArmyDistribution.custom_add_func[hero] do
            sleep()
        end
        BTD_Duel_ArmyDistribution.custom_add_func[hero][4] = function()
            startThread(Hero.CreatureInfo.Add, %hero, 976, random(16) + 71)
        end
    end
end)

NewDayEvent.AddListener("btd_duel_wulfstan_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(wulfstan_spec_duel.heroes, hero) then
                local avenger = "avenger_"..(3 - GetObjectOwner(hero))
                local count = GetObjectCreatures(avenger, CREATURE_BROWLER)
                RemoveObjectCreatures(avenger, CREATURE_BROWLER, count)
                while GetObjectCreatures(avenger, CREATURE_BROWLER) > 0 do
                    sleep()
                end
                AddObjectCreatures(avenger, 976, count)
            end
        end
    end
    --
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(wulfstan_spec_duel.heroes, hero) then
                local attack_to_add = floor(GetHeroStat(hero, STAT_DEFENCE) / wulfstan_spec_duel.offence_divisor)
                if attack_to_add ~= 0 then
                    Hero.Stats.Change(hero, STAT_ATTACK, attack_to_add)
                end
            end
        end
    end
end)
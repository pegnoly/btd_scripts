nathaniel_spec = {
    heroes = {"Nathaniel"},
    lvl_divisor = 5,
    grow_per_divisor = 10
}

NewDayEvent.AddListener("BTD_RMG_nathaniel_new_day",
function(day)
    if mod(day, 7) == 1 and day ~= 1 then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and contains(nathaniel_spec.heroes, hero) then
                local peasants_to_add = floor(GetHeroLevel(hero) / nathaniel_spec.lvl_divisor) * 10
                if peasants_to_add > 0 then
                    startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_HEAVEN, 1, peasants_to_add)
                end
            end
        end
    end
end)
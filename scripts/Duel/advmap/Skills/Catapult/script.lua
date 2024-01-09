constructor =
{
  heroes_active = {}
}

NewDayEvent.AddListener("BTD_duel_constructor_new_day_event",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, PERK_CATAPULT) then
                --for machine = WAR_MACHINE_BALLISTA, WAR_MACHINE_AMMO_CART do
                    pcall(GiveHeroWarMachine, hero, WAR_MACHINE_AMMO_CART)
                --end
            end
        end
    end
end)
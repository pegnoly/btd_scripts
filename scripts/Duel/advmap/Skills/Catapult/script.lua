constructor =
{
  heroes_active = {}
}

NewDayEvent.AddListener("BTD_duel_constructor_new_day_event",
function(day)
    if day == BTD_duel_day_sequence.prefight_day then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_CATAPULT) then
                for machine = WAR_MACHINE_BALLISTA, WAR_MACHINE_AMMO_CART do
                    pcall(GiveHeroWarMachine, hero, machine)
                end
            end
        end
    end
end)
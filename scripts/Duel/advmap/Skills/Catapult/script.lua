constructor =
{
  heroes_active = {}
}

NewDayEvent.AddListener("constructor_new_day_event",
function(day)
    if day == BTD_FIGHT_DAY then
        for hero, alive in AdvMapHeroesInfo.alive_heroes do
            if hero and alive and HasHeroSkill(hero, PERK_CATAPULT) then
                for machine = WAR_MACHINE_BALLISTA, WAR_MACHINE_AMMO_CART do
                    pcall(GiveHeroWarMachine, hero, machine)
                end
            end
        end
    end
end)
runic_stoneworks = 
{
    def_amount = 1,
    bonuses_by_town_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_runic_stoneworks_add_hero",
function(hero)
    if Hero.Params.Town(hero) ~= TOWN_FORTRESS then
        return
    end
    --
    runic_stoneworks.bonuses_by_town_for_hero[hero] = {}
    startThread(
    function ()
        local owner = GetObjectOwner(%hero)
        while 1 do
            if IsHeroAlive(%hero) then
                for i, town in Player.GetTowns(owner) do
                    if not runic_stoneworks.bonuses_by_town_for_hero[%hero][town] then
                        if GetTownRace(town) == TOWN_FORTRESS and GetTownBuildingLevel(town, TOWN_BUILDING_FORTRESS_RUNIC_STONEWORKS) > 0 then
                            runic_stoneworks.bonuses_by_town_for_hero[%hero][town] = 1
                            ChangeHeroStat(%hero, STAT_DEFENCE, runic_stoneworks.def_amount)
                        end
                    else
                        if GetTownBuildingLevel(town, TOWN_BUILDING_FORTRESS_RUNIC_STONEWORKS) == 0 then
                            runic_stoneworks.bonuses_by_town_for_hero[%hero][town] = nil
                            ChangeHeroStat(%hero, STAT_DEFENCE, -runic_stoneworks.def_amount)
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)
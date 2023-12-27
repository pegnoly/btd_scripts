preserve_sparkling_fountain =
{
    move_points_per_building = 400,
    buildings_used_for_hero = {}
}

function CalcFountains(player) 
    local count = 0
    for i, town in Player.GetTowns(player) do
        if (GetTownRace(town) == TOWN_PRESERVE) and (GetTownBuildingLevel(town, TOWN_BUILDING_PRESERVE_MYSTIC_POND) == 2) then
            count = count + 1
        end
    end
    return count
end

AddHeroEvent.AddListener("BTD_RMG_sparkling_fountain_add_hero",
function(hero)
    preserve_sparkling_fountain.buildings_used_for_hero[hero] = {}
end)

MapLoadingEvent.AddListener("BTD_RMG_sparkling_fountain_init",
function()
    for i, type in {
        "BUILDING_RALLY_FLAG", "BUILDING_OASIS", "BUILDING_LAKE_OF_SCARLET_SWAN", "BUILDING_FONTAIN_OF_FORTUNE",
        "BUILDING_FONTAIN_OF_YOUTH", "BUILDING_FAERIE_RING", "BUILDING_IDOL_OF_FORTUNE", "BUILDING_TEMPLE",
        "BUILDING_BUOY", "BUILDING_MERMAIDS"} do
        for j, object in GetObjectNamesByType(type) do
            Touch.SetTrigger(object)
            Touch.SetFunction(object, "_touch",
            function(hero, obj)
                if not preserve_sparkling_fountain.buildings_used_for_hero[hero][obj] then
                    startThread(SparklingFountain_TryGiveMP, hero, obj)
                end
            end)
        end
    end
end)

CombatResultsEvent.AddListener("BTD_RMG_sparkling_fountain_combat_results",
function(fight_id)
    for side = 0, 1 do
        local hero = GetSavedCombatArmyHero(fight_id, side)
        if hero then
            for object, _ in preserve_sparkling_fountain.buildings_used_for_hero[hero] do
                preserve_sparkling_fountain.buildings_used_for_hero[hero][object] = nil
            end
        end
    end
end)

function SparklingFountain_TryGiveMP(hero, object)
    if Hero.Params.Class(hero) == HERO_CLASS_RANGER then
        local fountains_count = CalcFountains(GetObjectOwner(hero))
        if fountains_count > 0 then
            print("Fountains count: ", fountains_count)
            preserve_sparkling_fountain.buildings_used_for_hero[hero][object] = 1
            local current_move_points = GetHeroStat(hero, STAT_MOVE_POINTS)
            ChangeHeroStat(hero, STAT_MOVE_POINTS, fountains_count * preserve_sparkling_fountain.move_points_per_building)
        end
    end
end

NewDayEvent.AddListener("BTD_RMG_sparkling_fountain_new_day",
function(day)
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive and (Hero.Params.Class(hero) == HERO_CLASS_RANGER) then
            local object = GetHeroTown(hero) or hero
            local fountains_count = CalcFountains(GetObjectOwner(object))
            if fountains_count > 0 then
                local know = GetHeroStat(hero, STAT_KNOWLEDGE)
                local curr_mana = GetHeroStat(hero, STAT_MANA_POINTS)
                print("curr_mana: ", curr_mana)
                local max_mana = know * (HasHeroSkill(hero, PERK_INTELLIGENCE) and 15 or 10)
                print("max_mana: ", max_mana)
                local mana_to_restore = know * (1 + (HasHeroSkill(hero, PERK_MYSTICISM) and 1 or 0))
                print("mana_to_restore before: ", mana_to_restore)
                local mana_diff = max_mana - curr_mana
                if mana_diff > 0 then
                    mana_to_restore = (mana_diff > mana_to_restore) and mana_to_restore or mana_diff
                    print("mana_to_restore after: ", mana_to_restore)
                    ChangeHeroStat(hero, STAT_MANA_POINTS, mana_to_restore)
                end
            end
        end
    end
end)
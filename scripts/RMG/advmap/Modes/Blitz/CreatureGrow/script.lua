while not MCCS_TEMPLATE_TYPE and TEMPLATE_TYPE_Blitz do
    sleep()
end

blitz_creature_grow = {
    town_build_info = {}
}

MapLoadingEvent.AddListener("BTD_RMG_blitz_mode_init_creature_grow",
function()
    --print("Here, ", MCCS_TEMPLATE_TYPE)
    if MCCS_TEMPLATE_TYPE == TEMPLATE_TYPE_Blitz then
        --print("Blitz template detected")
        for i, town in GetObjectNamesByType("TOWN") do
            blitz_creature_grow.town_build_info[town] = {
                [TOWN_BUILDING_DWELLING_1] = 1,
                [TOWN_BUILDING_DWELLING_2] = 1,
                [TOWN_BUILDING_DWELLING_3] = 1,
                [TOWN_BUILDING_DWELLING_4] = 1,
                [TOWN_BUILDING_DWELLING_5] = 1,
                [TOWN_BUILDING_DWELLING_6] = 1,
                [TOWN_BUILDING_DWELLING_7] = 1
            }
            startThread(BTD_BlitzMode_CheckTownDwellingsUpgrade, town)
        end
    end
end)

function BTD_BlitzMode_CheckTownDwellingsUpgrade(town)
    local town_type = GetTownRace(town)
    while 1 do
        for dwelling, not_upgraded in blitz_creature_grow.town_build_info[town] do
            --print("dwells: ", blitz_creature_grow.town_build_info[town])
            if not_upgraded and (GetTownBuildingLevel(town, dwelling) > 0) then
                --print("Dwelling ", dwelling, " upgraded in town ", town)
                blitz_creature_grow.town_build_info[town][dwelling] = nil
                local creature = TOWN_DWELLS[town_type][dwelling - 6]
                --print("Creature must grow now")
                local current_grow = GetObjectDwellingCreatures(town, creature)
                SetObjectDwellingCreatures(town, creature, current_grow * 2)
            end
        end
        sleep()
    end
end
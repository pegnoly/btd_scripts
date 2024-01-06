while not BLUEPRINTS_DWELL_13 and not ARTIFACT_BLUEPRINT_DWELL_13 do
    sleep()
end



blueprints_dwell13_rmg = {

}

CustomAbility.callbacks["blueprint_dwell13_custom"] = {
    question = "/scripts/RMG/advmap/Features/Blueprints/Dwell13/question.txt",
    func = function(hero)
        local player = GetObjectOwner(hero)
        local town
        for i, _town in Player.GetTowns(player) do
            if IsHeroInTown(hero, _town, 1, 0) then
                town = _town
                break
            end
        end
        local town_level = 10 --Blueprints_GetTownLevel(town)
        local race = GetTownRace(town)
        --for dwell, info in BLUEPRINTS_DWELL_13[town] do
        local path = BLUEPRINTS_DWELL_13[race].path
        local any_building_flag
        for building = TOWN_BUILDING_DWELLING_1, TOWN_BUILDING_DWELLING_3 do
            local building_info = BLUEPRINTS_DWELL_13[race][building]
            -- проверка на наличие зависимых зданий
            local reachable_flag = 1
            if building_info.depends_on then
                for dependency_building, level in building_info.depends_on do
                    if GetTownBuildingLevel(town, dependency_building) < level then
                        reachable_flag = nil
                        break
                    end
                end  
            end
            --
            if reachable_flag then
                local max_level = GetTownBuildingMaxLevel(town, building)
                local current_level = GetTownBuildingLevel(town, building)
                if current_level < max_level then
                    local next_level = current_level + 1
                    local can_be_build = 1
                    if building_info.town_level <= town_level then
                        for res, amount in building_info.upgrades[next_level].cost do
                            if GetPlayerResource(player, res) < amount then
                                can_be_build = nil
                                break
                            end
                        end
                    end
                    if can_be_build then
                        any_building_flag = 1
                        if MCCS_QuestionBoxForPlayers(player, {
                            "/scripts/RMG/advmap/Features/Blueprints/Dwell13/wanna_build.txt"; 
                            race_color = RACE_COLORS[race],
                            name = path..building_info.upgrades[next_level].name
                        }) then
                            for res, amount in building_info.upgrades[next_level].cost do
                                Resource.Change(hero, res, -amount)
                            end
                            UpgradeTownBuilding(town, building)
                            return
                        end
                    end
                end
            end
        end
        if not any_building_flag then
            startThread(MCCS_MessageBoxForPlayers, "/scripts/RMG/advmap/Features/Blueprints/Dwell13/nothing_to_build.txt")
        end
    end
}

AddHeroEvent.AddListener("btd_rmg_blueprint_dwell13_custom_add_hero_listener",
function(hero)
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_dwell13_custom"] then
                    if HasArtefact(%hero, ARTIFACT_BLUEPRINT_DWELL_13, 1) then
                        for i, town in Player.GetTowns(GetObjectOwner(%hero)) do
                            if IsHeroInTown(%hero, town, 1, 0) then
                                CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_dwell13_custom"] = 1
                                break
                            end
                        end
                    end
                else
                    if not HasArtefact(%hero, ARTIFACT_BLUEPRINT_DWELL_13, 1) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_dwell13_custom"] = nil
                    else
                        local town_flag = nil
                        for i, town in Player.GetTowns(GetObjectOwner(%hero)) do
                            if IsHeroInTown(%hero, town, 1, 0) then
                                town_flag = 1
                                break
                            end
                        end
                        if not town_flag then
                            CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_dwell13_custom"] = nil
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)
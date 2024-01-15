while not BLUEPRINTS_MGUILD and not ARTIFACT_BLUEPRINT_MGUILD do
    sleep()
end



blueprints_mguild_rmg = {

}

CustomAbility.callbacks["blueprint_mguild_custom"] = {
    question = "/scripts/RMG/advmap/Features/Blueprints/Mguild/question.txt",
    func = function(hero)
        local player = GetObjectOwner(hero)
        local town
        for i, _town in Player.GetTowns(player) do
            if IsHeroInTown(hero, _town, 1, 0) then
                town = _town
                break
            end
        end
        local town_level = Blueprints_GetTownLevel(town)
        local race = GetTownRace(town)
        local building_info = BLUEPRINTS_MGUILD[race]
        local path = BLUEPRINTS_MGUILD[race].path
        local buildable_flag
        if town_level >= building_info.town_level then
            local reachable_flag = 1
            if building_info.depends_on then
                for dependency_building, level in building_info.depends_on do
                    if GetTownBuildingLevel(town, dependency_building) < level then
                        reachable_flag = nil
                        break
                    end
                end  
            end
            if reachable_flag then
                local current_level = GetTownBuildingLevel(town, TOWN_BUILDING_MAGIC_GUILD)
                local next_level = current_level + 1
                local next_level_info = building_info.upgrades[next_level]
                local can_be_build = 1
                for res, amount in next_level_info.cost do
                    if GetPlayerResource(player, res) < amount then
                        can_be_build = nil
                        break
                    end
                    if can_be_build then
                        buildable_flag = 1
                        if MCCS_QuestionBoxForPlayers(player, {
                            "/scripts/RMG/advmap/Features/Blueprints/Mguild/wanna_build.txt"; 
                            race_color = RACE_COLORS[race],
                            name = path..building_info.upgrades[next_level].name
                        }) then
                            for res, amount in building_info.upgrades[next_level].cost do
                                Resource.Change(hero, res, -amount)
                            end
                            UpgradeTownBuilding(town, TOWN_BUILDING_MAGIC_GUILD)
                            RemoveArtefact(hero, ARTIFACT_BLUEPRINT_MGUILD)
                            return
                        else
                            return
                        end
                    end
                end
            end
        end
        if not buildable_flag then
            startThread(MCCS_MessageBoxForPlayers, player, "/scripts/RMG/advmap/Features/Blueprints/Mguild/nothing_to_build.txt")
        end
    end
}

AddHeroEvent.AddListener("btd_rmg_blueprint_mguild_custom_add_hero_listener",
function(hero)
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_mguild_custom"] then
                    if HasArtefact(%hero, ARTIFACT_BLUEPRINT_MGUILD, 1) then
                        for i, town in Player.GetTowns(GetObjectOwner(%hero)) do
                            if IsHeroInTown(%hero, town, 1, 0) then
                                CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_mguild_custom"] = 1
                                break
                            end
                        end
                    end
                else
                    if not HasArtefact(%hero, ARTIFACT_BLUEPRINT_MGUILD, 1) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_mguild_custom"] = nil
                    else
                        local town_flag = nil
                        for i, town in Player.GetTowns(GetObjectOwner(%hero)) do
                            if IsHeroInTown(%hero, town, 1, 0) then
                                town_flag = 1
                                break
                            end
                        end
                        if not town_flag then
                            CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_ARTIFACT][%hero]["blueprint_mguild_custom"] = nil
                        end
                    end
                end
            end
            sleep()
        end
    end)
end)
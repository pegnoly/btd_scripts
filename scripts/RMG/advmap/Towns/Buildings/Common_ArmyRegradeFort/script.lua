TOWN_BUILDING_ARMY_REGRADE_FORT = 22
CUSTOM_ABILITY_ACTIVATE_ARMY_REGRADE_FORT = 3

army_regrade_fort =
{
    path = "/scripts/RMG/advmap/Towns/Buildings/Common_ArmyRegradeFort/",
    active_for_hero = {},

    -- TODO. Add option to tables generation to detect actual non-grades
    non_grades = 
    {
        CREATURE_PEASANT, CREATURE_ARCHER, CREATURE_FOOTMAN, CREATURE_GRIFFIN, CREATURE_PRIEST, CREATURE_CAVALIER, CREATURE_ANGEL,
        CREATURE_FAMILIAR, CREATURE_DEMON, CREATURE_HELL_HOUND, CREATURE_SUCCUBUS, CREATURE_NIGHTMARE, CREATURE_PIT_FIEND, CREATURE_DEVIL,
        CREATURE_SKELETON, CREATURE_WALKING_DEAD, CREATURE_MANES, CREATURE_VAMPIRE, CREATURE_LICH, CREATURE_WIGH, CREATURE_BONE_DRAGON,
        CREATURE_PIXIE, CREATURE_BLADE_JUGGLER, CREATURE_WOOD_ELF, CREATURE_DRUID, CREATURE_UNICORN, CREATURE_TREANT, CREATURE_GREEN_DRAGON,
        CREATURE_GREMLIN, CREATURE_STONE_GARGOYLE, CREATURE_IRON_GOLEM, CREATURE_MAGI, CREATURE_GENIE, CREATURE_RAKSHASA, CREATURE_GIANT,
        CREATURE_SCOUT, CREATURE_WITCH, CREATURE_MINOTAUR, CREATURE_RIDER, CREATURE_HYDRA, CREATURE_MATRON, CREATURE_DEEP_DRAGON,
        CREATURE_DEFENDER, CREATURE_AXE_FIGHTER, CREATURE_BEAR_RIDER, CREATURE_BROWLER, CREATURE_RUNE_MAGE, CREATURE_THANE, CREATURE_FIRE_DRAGON,
        CREATURE_GOBLIN, CREATURE_CENTAUR, CREATURE_ORC_WARRIOR, CREATURE_SHAMAN, CREATURE_ORCCHIEF_BUTCHER, CREATURE_WYVERN, CREATURE_CYCLOP
    }
}

AddHeroEvent.AddListener("BTD_RMG_regrade_ability_add_hero",
function(hero)
    startThread(
    function ()
        while 1 do
            if IsHeroAlive(%hero) then
                if not army_regrade_fort.active_for_hero[%hero] then
                    if ArmyRegradeFort_CanBeActivated(%hero) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_TOWN][%hero]["regrade_fort"] = 1
                        army_regrade_fort.active_for_hero[%hero] = 1
                    end
                else
                    if not ArmyRegradeFort_CanBeActivated(%hero) then
                        CustomAbility.callbacks_for_hero[CUSTOM_ABILITY_TOWN][%hero]["regrade_fort"] = nil
                        army_regrade_fort.active_for_hero[%hero] = nil
                    end
                end
            end
            sleep()
        end     
    end)
end)

function ArmyRegradeFort_CanBeActivated(hero)
    local player = GetObjectOwner(hero)
    if not GetHeroTown(hero) then
        for i, town in Player.GetTowns(player) do
            local fort_id = GetTownRace(town) == TOWN_DUNGEON and 21 or TOWN_BUILDING_ARMY_REGRADE_FORT
            if GetTownBuildingLevel(town, fort_id) > 0 then
                return 1
            end
        end
    end
    return nil
end

CustomAbility.callbacks["regrade_fort"] = {
    question = army_regrade_fort.path.."wanna_use.txt",
    func = function(hero)
        for slot = 0, 6 do
            local creature, count = GetObjectArmySlotCreature(hero, slot)
            if not (creature == 0 or count == 0) then
                if contains(army_regrade_fort.non_grades, creature) then
                    startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), army_regrade_fort.path.."non_grades_in_army.txt")
                    return
                end
            end
        end
        MakeHeroInteractWithObject(hero, "BTD_upgrade_hill_fort")
    end
}
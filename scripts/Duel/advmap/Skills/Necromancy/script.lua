necromancy = {
    path = "/scripts/Duel/Skills/Necromancy/",
    stack_info = {
        ["necromancy_t1_p1"] = {tier = 1, count = 84},
        ["necromancy_t2_p1"] = {tier = 2, count = 36},
        ["necromancy_t3_p1"] = {tier = 3, count = 19},
        ["necromancy_t4_p1"] = {tier = 4, count = 9},
        ["necromancy_t5_p1"] = {tier = 5, count = 6},
        ["necromancy_t6_p1"] = {tier = 6, count = 4},
        ["necromancy_t7_p1"] = {tier = 7, count = 3},
        ["necromancy_t1_p2"] = {tier = 1, count = 84},
        ["necromancy_t2_p2"] = {tier = 2, count = 36},
        ["necromancy_t3_p2"] = {tier = 3, count = 19},
        ["necromancy_t4_p2"] = {tier = 4, count = 9},
        ["necromancy_t5_p2"] = {tier = 5, count = 6},
        ["necromancy_t6_p2"] = {tier = 6, count = 4},
        ["necromancy_t7_p2"] = {tier = 7, count = 3},
    },

    charges_for_hero = {
    }
}

AddHeroEvent.AddListener("BTD_duel_necromancy_add_hero",
function(hero)
    if Hero.Params.Class(hero) == HERO_CLASS_NECROMANCER then
        necromancy.charges_for_hero[hero] = -1
    end
end)

function Necromancy_TouchCreature(hero, object)
    local player = GetObjectOwner(hero)
    if necromancy.charges_for_hero[hero] == 0 then
        startThread(MCCS_MessageBoxForPlayers, player, necromancy.path.."not_enough_charges.txt")
        return
    end
    if MCCS_QuestionBoxForPlayers(player, necromancy.path.."wanna_join.txt") then
        local tier = necromancy.stack_info[object].tier
        local count = necromancy.stack_info[object].count
        necromancy.charges_for_hero[hero] = necromancy.charges_for_hero[hero] - 1
        startThread(Hero.CreatureInfo.DefaultGrow, hero, TOWN_NECROMANCY, tier, count)
    end
end

MapLoadingEvent.AddListener("BTD_duel_necromancy_creatures_init",
function()
    for stack, info in necromancy.stack_info do
        Touch.DisableMonster(stack, DISABLED_INTERACT, 0, necromancy.path.."stack_names/l"..info.tier..".txt")
        Touch.SetFunction(stack, "_touch", Necromancy_TouchCreature)
    end
end)

function Necromancy_TouchHelper(hero, object)
    local player = GetObjectOwner(hero)
    if MCCS_QuestionBoxForPlayers(player, necromancy.path.."helper_msg.txt") then
        necromancy.charges_for_hero[hero] = GetHeroSkillMastery(hero, SKILL_NECROMANCY)
        local x, y, f = RegionToPoint("p"..player.."_necro_tp_point")
        SetObjectPosition(hero, x, y, f)
    end 
end

MapLoadingEvent.AddListener("BTD_duel_necromancy_helper_init",
function()
    for player = PLAYER_1, PLAYER_2 do
        if GetPlayerRace(player) == TOWN_NECROMANCY then
            local x, y, f = RegionToPoint("p"..player.."_helper_spawn_point")
            local helper = "necromancy_helper_p"..player
            CreateMonster(helper, CREATURE_VAMPIRE_LORD, 1, x, y, f, 
                            MONSTER_MOOD_FRIENDLY, MONSTER_COURAGE_ALWAYS_JOIN, 180, 1)
            while not IsObjectExists(helper) do
                sleep()
            end
            Touch.DisableMonster(helper, DISABLED_INTERACT, 0, necromancy.path.."stack_names/helper.txt")
            Touch.SetFunction(helper, "_touch", Necromancy_TouchHelper)
        end
    end
end)
RES_BONUS_RESOURCE = 1
RES_BONUS_GOLD = 2

while not MCCS_GAME_MODES and GAME_MODE_BLITZ do
    sleep()
end

btd_start_resources = {
    gold = 13000,
    resources = {
        [TOWN_PRESERVE] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 6, [CRYSTAL] = 8, [SULFUR] = 6, [GEM] = 8},
        [TOWN_HEAVEN] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 6, [CRYSTAL] = 8, [SULFUR] = 6, [GEM] = 8},
        [TOWN_ACADEMY] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 6, [CRYSTAL] = 8, [SULFUR] = 6, [GEM] = 8},
        [TOWN_FORTRESS] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 6, [CRYSTAL] = 8, [SULFUR] = 6, [GEM] = 8},
        [TOWN_INFERNO] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 8, [CRYSTAL] = 6, [SULFUR] = 8, [GEM] = 6},
        [TOWN_DUNGEON] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 8, [CRYSTAL] = 6, [SULFUR] = 8, [GEM] = 6},
        [TOWN_STRONGHOLD] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 8, [CRYSTAL] = 6, [SULFUR] = 8, [GEM] = 6},
        [TOWN_NECROMANCY] = {[WOOD] = 16, [ORE] = 16, [MERCURY] = 8, [CRYSTAL] = 6, [SULFUR] = 8, [GEM] = 6}
    },
    blitz_gold_multiplier = 2,
    blitz_rare_multiplier = 2,
    blitz_wood_multiplier = 1.5
}

function StartResources_GetBonusType(player)
    if (GetPlayerResource(player, WOOD) > 10) or (GetPlayerResource(player, ORE) > 10) or
        (GetPlayerResource(player, MERCURY) > 5) or (GetPlayerResource(player, CRYSTAL) > 5) or
        (GetPlayerResource(player, SULFUR) > 5) or (GetPlayerResource(player, GEM) > 5) then
        return RES_BONUS_RESOURCE
    elseif GetPlayerResource(player, GOLD) > 10000 then
        return RES_BONUS_GOLD
    end
    return nil
end

MapLoadingEvent.AddListener("BTD_rmg_init_start_resources",
function()
    -- if day == 1 then
        for player = PLAYER_1, PLAYER_8 do
            if GetPlayerState(player) == PLAYER_ACTIVE then
                startThread(StartResources_GiveStartBonus, player)
            end
        end 
    -- end
end)

function StartResources_GiveStartBonus(player)
    local actual_resources = {}
    for res = WOOD, GOLD do 
        actual_resources[res] = GetPlayerResource(player, res)
    end
    local bonus_type = StartResources_GetBonusType(player)
    if bonus_type then
        if bonus_type == RES_BONUS_GOLD then
            actual_resources[GOLD] = btd_start_resources.gold
        else
            local race = GetPlayerRace(player)
            for res = WOOD, GEM do
                actual_resources[res] = btd_start_resources.resources[race][res]
            end
        end
    end
    local is_blitz = MCCS_GAME_MODES[GAME_MODE_BLITZ]
    SetPlayerStartResources(
        player,
        actual_resources[WOOD] * (is_blitz and btd_start_resources.blitz_wood_multiplier or 1),
        actual_resources[ORE] * (is_blitz and btd_start_resources.blitz_wood_multiplier or 1),
        actual_resources[MERCURY] * (is_blitz and btd_start_resources.blitz_rare_multiplier or 1),
        actual_resources[CRYSTAL] * (is_blitz and btd_start_resources.blitz_rare_multiplier or 1),
        actual_resources[SULFUR] * (is_blitz and btd_start_resources.blitz_rare_multiplier or 1),
        actual_resources[GEM] * (is_blitz and btd_start_resources.blitz_rare_multiplier or 1),
        actual_resources[GOLD] * (is_blitz and btd_start_resources.blitz_gold_multiplier or 1)
    )
end

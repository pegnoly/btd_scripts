RES_BONUS_RESOURCE = 1
RES_BONUS_GOLD = 2

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
    }
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
    local bonus_type = StartResources_GetBonusType(player)
    if bonus_type then
        if bonus_type == RES_BONUS_GOLD then
            SetPlayerResource(player, GOLD, btd_start_resources.gold)
        else
            local race = GetPlayerRace(player)
            SetPlayerStartResources(
                player,
                btd_start_resources.resources[race][WOOD],
                btd_start_resources.resources[race][ORE],
                btd_start_resources.resources[race][MERCURY],
                btd_start_resources.resources[race][CRYSTAL],
                btd_start_resources.resources[race][SULFUR],
                btd_start_resources.resources[race][GEM],
                10000
            )
        end
    end
end

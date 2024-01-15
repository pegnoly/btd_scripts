mines_rmg = {
    was_captured = {},
    types_to_res_info = {
        ["SAWMILL"] = {res = WOOD, count = 2},
        ["ORE_PIT"] = {res = ORE, count = 2},
        ["ALCHEMIST_LAB"] = {res = MERCURY, count = 1},
        ["CRYSTAL_CAVERN"] = {res = CRYSTAL, count = 1},
        ["GEM_POND"] = {res = GEM, count = 1},
        ["SULFUR_DUNE"] = {res = SULFUR, count = 1},
        ["GOLD_MINE"] = {res = GOLD, count = 1000}
    },
    mines_types = {}
}

MapLoadingEvent.AddListener("BTD_rmg_mines_init",
function()
    for i, type in {'SAWMILL', 'ORE_PIT', 'ALCHEMIST_LAB', 'CRYSTAL_CAVERN', 'GEM_POND', 'SULFUR_DUNE', 'GOLD_MINE'} do
        for j, mine in GetObjectNamesByType(type) do
            mines_rmg.mines_types[mine] = type
            Trigger(OBJECT_CAPTURE_TRIGGER, mine, "RMG_MineCaptured")
        end
    end
end)

function RMG_MineCaptured(p_owner, new_owner, hero, object)
    if new_owner ~= PLAYER_NONE and (not mines_rmg.was_captured[object]) then
        mines_rmg.was_captured[object] = 1
        local type = mines_rmg.mines_types[object]
        local info = mines_rmg.types_to_res_info[type]
        Resource.Change(hero, info.res, info.count)
    end
end
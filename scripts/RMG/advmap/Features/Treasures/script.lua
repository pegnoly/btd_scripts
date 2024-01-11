while not BTD_Treasures do
    sleep()
end

treasures_rmg = {
    names = {
        [TREASURE_WOOD] = "/Text/Game/Treasures/Wood/Name.txt",
        [TREASURE_ORE] = "/Text/Game/Treasures/Ore/Name.txt",
        [TREASURE_MERCURY] = "/Text/Game/Treasures/Mercury/Name.txt",
        [TREASURE_CRYSTAL] = "/Text/Game/Treasures/Crystals/Name.txt",
        [TREASURE_SULFUR] = "/Text/Game/Treasures/Sulfur/Name.txt",
        [TREASURE_GEMS] = "/Text/Game/Treasures/Gems/Name.txt",
        [TREASURE_GOLD] = "/Text/Game/Treasures/Gold/Name.txt",
        [TREASURE_CHEST] = "/Text/Game/Treasures/TreasureChest/Name.txt"
    },
    path = "/scripts/RMG/advmap/Features/Treasures/"
}

MapLoadingEvent.AddListener("btd_rmg_treasures_descs_init",
function()
    for treasure, info in BTD_Treasures do
        if info.type ~= TREASURE_CAMPFIRE and info.amount ~= 0 then
            if info.type == TREASURE_GOLD then
                OverrideObjectTooltipNameAndDescription(
                    treasure, 
                    treasures_rmg.names[info.type], 
                    treasures_rmg.path.."amounts/gold/"..(info.amount * 100)..".txt"
                )
            elseif info.type == TREASURE_CHEST then
                local desc = ""
                if info.amount == 1 then
                    desc = treasures_rmg.path.."amounts/chest/low.txt"
                elseif info.amount == 2 then
                    desc = treasures_rmg.path.."amounts/chest/medium.txt"
                else
                    desc = treasures_rmg.path.."amounts/chest/big.txt"
                end
                OverrideObjectTooltipNameAndDescription(
                    treasure, 
                    treasures_rmg.names[info.type], 
                    desc
                )
            else
                OverrideObjectTooltipNameAndDescription(
                    treasure, 
                    treasures_rmg.names[info.type], 
                    treasures_rmg.path.."amounts/common/"..info.amount..".txt"
                )
            end
        end
    end
end)
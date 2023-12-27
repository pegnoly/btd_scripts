dwarven_mine_rmg = {
    mines_by_players = {},
    fx_by_rots = {
        [0] = {0.5, -0.5},
        [2] = {0.5, 0.5},
        [3] = {-0.5, 0.5},
        [5] = {-0.5, -0.5}
    }
}

function CaptureMine(hero, object)
    local owner = GetObjectOwner(hero)
    local race = GetPlayerRace(owner)
    OverrideObjectTooltipNameAndDescription(object, 
        "/MapObjects/BTD/DwarfMine/name.txt", 
        "/scripts/RMG/advmap/Objects/NewObjects/DwarvenMine/names/player_"..owner..".txt")
    local fx = CaptureFX[race]..CaptureColor[owner]
    pcall(StopVisualEffects, object.."_fx")
    local rot = round(BTD_DwarvenMinesRots[object])
    print("rot ", rot)
    if dwarven_mine_rmg.fx_by_rots[rot] then
        local fx_pos = dwarven_mine_rmg.fx_by_rots[rot]
        print("fx_pos ", fx_pos)
        PlayVisualEffect("/Effects/_(Effect)/Buildings/Capture/Start_dust_S.xdb#xpointer(/Effect)", object, "", fx_pos[1], fx_pos[2])
        PlayVisualEffect(fx, object, object.."_fx", fx_pos[1], fx_pos[2], 1)
    else
        PlayVisualEffect("/Effects/_(Effect)/Buildings/Capture/Start_dust_S.xdb#xpointer(/Effect)", object)
        PlayVisualEffect(fx, object, object.."_fx", 0, 0, 1)
    end
    dwarven_mine_rmg.mines_by_players[object] = owner
end

function DwarvenMine_GiveResources(player, count)
    print("Dwarven mine: give ", count " to player ", player)
    for res = MERCURY, GEM do
        local curr_count = GetPlayerResource(player, res)
        SetPlayerResource(player, res, curr_count + count)
    end
end

NewDayEvent.AddListener("BTD_RMG_dwarven_mine_new_day",
function(day)
    if GetDate(DAY_OF_WEEK) == 1 and GetDate(DAY) ~= 1 then
        local mines_count_for_owner = {}
        for mine, owner in dwarven_mine_rmg.mines_by_players do
            if mine and owner then
                if not mines_count_for_owner[owner] then
                    mines_count_for_owner[owner] = 1
                else
                    mines_count_for_owner[owner] = mines_count_for_owner[owner] + 1
                end
            end
        end
        print("mines: ", mines_count_for_owner)
        for owner, count in mines_count_for_owner do
            for res = MERCURY, GEM do
                local curr_count = GetPlayerResource(owner, res)
                SetPlayerResource(owner, res, curr_count + count)
            end
        end
    end
end)
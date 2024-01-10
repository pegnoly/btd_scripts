while not MCCS_GAME_MODES do
    sleep()
end

wc_capture_object = {
    path = "/scripts/RMG/advmap/Features/WinConditions/CaptureObject/",
    town_name = "wc_capture_town",
    delay = -1,
    first_capture_flag = nil,
    current_owner = PLAYER_NONE,
    current_delay_for_owner = -1
}

MapLoadingEvent.AddListener("BTD_RMG_win_condition_capture_init",
function()
    if MCCS_GAME_MODES[GAME_MODE_CAPTURE_OBJECT] then
        for player = PLAYER_1, PLAYER_8 do
            if Player.IsActive(player) then
                Quest.Start("WIN_CONDITION_CAPTURE_OBJECT", nil, player)
            end
        end
        wc_capture_object.delay = MCCS_GAME_MODES[GAME_MODE_CAPTURE_OBJECT].delay
        Trigger(OBJECT_CAPTURE_TRIGGER, wc_capture_object.town_name, "WC_CaptureTownCaptured")
        NewDayEvent.AddListener("BTD_RMG_wc_capture_new_day", WC_CaptureNewDay)
    end
end)

function WC_CaptureTownCaptured(p_owner, new_owner, hero, object) 
    if new_owner ~= PLAYER_NONE then
        if not wc_capture_object.first_capture_flag then
            wc_capture_object.first_capture_flag = 1
            for player = PLAYER_1, PLAYER_8 do
                if Player.IsActive(player) and player ~= new_owner then
                    startThread(MCCS_MessageBoxForPlayers, player, {
                        wc_capture_object.path.."first_capture.txt"; player_id = new_owner, days_count = wc_capture_object.delay
                    })
                end
            end
        end
        -- 
        wc_capture_object.current_owner = new_owner
        wc_capture_object.current_delay_for_owner = wc_capture_object.delay
    end
end

function WC_CaptureNewDay(day) 
    if wc_capture_object.current_owner ~= PLAYER_NONE then
        wc_capture_object.current_delay_for_owner = wc_capture_object.current_delay_for_owner - 1
        if wc_capture_object.current_delay_for_owner == 0 then
            for player = PLAYER_1, PLAYER_8 do
                if Player.IsActive(player) then
                    startThread(MCCS_MessageBoxForPlayers, player, {
                        wc_capture_object.path.."win_message.txt"; player_id = wc_capture_object.current_owner
                    })
                    sleep(10)
                    Win(wc_capture_object.current_owner)
                end
            end
        end
    end
end
BTD_duel_day_sequence = {
    level_army_day = -1,
    freeroam_day = -1,
    prefight_day = -1,
    fight_day = -1
}

function BTD_Duel_DaySequenceInit()
    local date = GetDate(DAY)
    BTD_duel_day_sequence.level_army_day = date + 1
    BTD_duel_day_sequence.freeroam_day = date + 2
    BTD_duel_day_sequence.prefight_day = date + 3
    BTD_duel_day_sequence.fight_day = date + 4
end
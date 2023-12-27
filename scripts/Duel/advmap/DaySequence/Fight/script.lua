FIGHT_START_TYPE_RANDOM = 1
FIGHT_START_TYPE_SELECT = 2

btd_duel_fight_day = {
    defender = "",
    attacker = "",
    pathfinding_flag = {}
}

NewDayEvent.AddListener("btd_duel_fight_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        btd_duel_fight_day.attacker = GetPlayerHeroes(PLAYER_1)[0]
        btd_duel_fight_day.defender  = GetPlayerHeroes(PLAYER_2)[0]
        for i, hero in {btd_duel_fight_day.attacker, btd_duel_fight_day.defender} do
            btd_duel_free_roam.free_roam_active_for_hero[hero] = nil
            ChangeHeroStat(hero, STAT_MOVE_POINTS, -9999)
            SetObjectEnabled(hero, 1)
            btd_duel_fight_day.pathfinding_flag[hero] = HasHeroSkill(hero, PERK_PATHFINDING)
        end
        --
        sleep(10)
        --
        if btd_duel_fight_day.pathfinding_flag[btd_duel_fight_day.attacker] and 
            (not btd_duel_fight_day.pathfinding_flag[btd_duel_fight_day.defender]) then
            MakeHeroInteractWithObject(
                btd_duel_fight_day.defender, 
                btd_duel_fight_day.attacker
            )
        elseif btd_duel_fight_day.pathfinding_flag[btd_duel_fight_day.defender] and 
            (not btd_duel_fight_day.pathfinding_flag[btd_duel_fight_day.attacker]) then
            MakeHeroInteractWithObject(
                btd_duel_fight_day.attacker, 
                btd_duel_fight_day.defender
            )
        else
            if random(2) == 1 then
                MakeHeroInteractWithObject(
                    btd_duel_fight_day.defender, 
                    btd_duel_fight_day.attacker
                )
            else
                MakeHeroInteractWithObject(
                    btd_duel_fight_day.attacker, 
                    btd_duel_fight_day.defender
                )
            end
        end
    end
end)
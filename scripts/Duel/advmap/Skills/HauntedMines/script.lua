haunted_mines_duel =
{
    level_multiplier = 2
}

NewDayEvent.AddListener("btd_duel_haunted_mines_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.fight_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, 223) then
                local count = GetHeroLevel(hero) * haunted_mines_duel.level_multiplier
                consoleCmd("@SetGameVar('"..hero.."_HAUNT_MINES_GHOSTS_COUNT', "..count..")")
            end
        end
    end
end)

CombatConnection.combat_scripts_paths['haunt_mines_common'] = '/scripts/Common/combat/Skills/HauntMines/script.lua'
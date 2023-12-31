scouting_duel = {
    non_banned_heroes_for_player = {[PLAYER_1] = {}, [PLAYER_2] = {}},
    path = "/scripts/Duel/advmap/Skills/Scouting/"
}

NewDayEvent.AddListener("btd_duel_scouting_new_day_listener",
function(day)
    if day == BTD_duel_day_sequence.freeroam_day then
        for hero, alive_status in AdvMapHeroesInfo.alive_heroes do
            if hero and alive_status == HERO_CONDITION_ALIVE and HasHeroSkill(hero, PERK_SCOUTING) then
                local player = GetObjectOwner(hero)
                local picked_enemy_hero = GetPlayerHeroes(3 - player)[0]
                local unpicked_heroes, n = {}, 0
                for i, hero in scouting_duel.non_banned_heroes_for_player[3 - player] do
                    if hero ~= picked_enemy_hero then
                        unpicked_heroes[n] = hero
                    end
                    n = n + 1
                end
                print("Picked enemy hero: ", picked_enemy_hero)
                --
                local unpicked_hero = Random.FromTable(unpicked_heroes)
                print("unpicked enemy hero: ", unpicked_hero)
                startThread(MCCS_MessageBoxForPlayers, player, {
                    scouting_duel.path.."form.txt";
                    hero_name = Hero.Params.Name(unpicked_hero),
                    has_attack = HasHeroSkill(picked_enemy_hero, SKILL_OFFENCE) and scouting_duel.path.."has.txt" or scouting_duel.path.."has_not.txt",
                    has_defence = HasHeroSkill(picked_enemy_hero, SKILL_DEFENCE) and scouting_duel.path.."has.txt" or scouting_duel.path.."has_not.txt",
                })
            end
        end
    end
end)
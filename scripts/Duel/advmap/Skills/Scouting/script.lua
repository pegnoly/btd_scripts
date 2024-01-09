scouting_duel = {
    non_banned_heroes_for_player = {[PLAYER_1] = {}, [PLAYER_2] = {}},
    path = "/scripts/Duel/advmap/Skills/Scouting/",
    active_for_hero = {}
}

AddHeroEvent.AddListener("btd_duel_scouting_add_hero_listener",
function(hero)
    scouting_duel.active_for_hero[hero] = nil
    startThread(
    function()
        while GetDate(DAY) ~= BTD_duel_day_sequence.freeroam_day do
            sleep()
        end
        while 1 do
            if IsHeroAlive(%hero) then
                if not scouting_duel.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, PERK_SCOUTING) then
                        scouting_duel.active_for_hero[%hero] = 1
                        startThread(ScoutingDuel_Activate, %hero)
                    end
                else
                    if not HasHeroSkill(%hero, PERK_SCOUTING) then
                        scouting_duel.active_for_hero[%hero] = nil
                    end
                end
            end
            sleep()
        end
    end)
end)

function ScoutingDuel_Activate(hero)
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
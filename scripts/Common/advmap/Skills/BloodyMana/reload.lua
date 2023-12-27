function BloodyManaReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, 224) then
            consoleCmd("@SetGameVar('"..hero.."_BLOODY_MANA', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['bloody_mana'] = '/scripts/Common/combat/Skills/BloodyMana/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_bloody_mana_reload', BloodyManaReload)")

function BloodyMana_PostCombat(hero, fight_id)
    print("bloody mana post_combat: ", hero)
    if HasHeroSkill(hero, 224) then
        consoleCmd("@local start_mana = GetGameVar('"..hero.."_BLOODY_MANA_START_MANA') startThread(BloodyMana_ConfigureMana, '"..hero.."', start_mana)")
    end
end

function BloodyMana_ConfigureMana(hero, start_mana)
    start_mana = start_mana + 0
    print("start_mana: ", start_mana)
    local hero_possible_mana = GetHeroStat(hero, STAT_KNOWLEDGE) * (HasHeroSkill(hero, HERO_SKILL_BARBARIAN_INTELLIGENCE) and 15 or 10)
    print("possible mana: ", hero_possible_mana)
    local hero_current_mana = GetHeroStat(hero, STAT_MANA_POINTS)
    print("current mana: ", hero_current_mana)
    local diff = -1
    local know_flag
    if start_mana > hero_possible_mana then
        print("here?")
        diff = hero_current_mana - start_mana
        local curr_know = GetHeroStat(hero, STAT_KNOWLEDGE)
        local know_to_add = ceil(hero_current_mana / 10) - ceil(hero_possible_mana / 10)
        if know_to_add > 0 then
            ChangeHeroStat(hero, STAT_KNOWLEDGE, know_to_add)
            while GetHeroStat(hero, STAT_KNOWLEDGE) ~= (curr_know + know_to_add) do
                sleep()
            end
            know_flag = know_to_add
        end
    else 
        print("or here?")
        diff = hero_current_mana - hero_possible_mana
    end
    sleep()
    if diff > 0 then
        print("diff: ", diff)
        ChangeHeroStat(hero, STAT_MANA_POINTS, -diff)
        if know_flag then
            ChangeHeroStat(hero, STAT_KNOWLEDGE, -know_flag)
        end
    end
end



consoleCmd("@AddPostCombatEvent('BTD_common_bloody_mana_post_combat', BloodyMana_PostCombat)")
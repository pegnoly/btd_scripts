lord_of_undead_common = {
    know_amount = 1,
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_common_lord_of_undead_add_hero_event",
function(hero)
    lord_of_undead_common.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not lord_of_undead_common.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
                        lord_of_undead_common.active_for_hero[%hero] = 1
                        ChangeHeroStat(hero, STAT_KNOWLEDGE, lord_of_undead_common.know_amount)
                        consoleCmd("@SetGameVar('"..%hero.."_LORD_OF_UNDEAD', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
                        lord_of_undead_common.active_for_hero[%hero] = nil
                        ChangeHeroStat(hero, STAT_KNOWLEDGE, -lord_of_undead_common.know_amount)
                        consoleCmd("@SetGameVar('"..%hero.."_LORD_OF_UNDEAD', '')")
                    end
                end
            end
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_common_lord_of_undead_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, NECROMANCER_FEAT_LORD_OF_UNDEAD) then
        consoleCmd("@SetGameVar('"..hero.."_LORD_OF_UNDEAD', '1')")
    end   
end)

CombatConnection.combat_scripts_paths['lord_of_undead_common'] = '/scripts/Common/combat/Skills/LordOfUndead/script.lua'
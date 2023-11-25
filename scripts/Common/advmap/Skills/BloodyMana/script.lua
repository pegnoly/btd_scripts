HERO_SKILL_BLOODY_MANA = 224

bloody_mana = {
    active_for_hero = {},
}

AddHeroEvent.AddListener("BTD_RMG_bloody_mana_add_hero",
function(hero)
    bloody_mana.active_for_hero[hero] = nil
    if Hero.Params.Town(hero) ~= TOWN_STRONGHOLD then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not bloody_mana.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_BLOODY_MANA) then
                        bloody_mana.active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_MANA', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_BLOODY_MANA) then
                        bloody_mana.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_MANA', '')")
                    end
                end
            end
            sleep()
        end 
    end)
end)

RespawnHeroEvent.AddListener("BTD_RMG_bloody_mana_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, HERO_SKILL_BLOODY_MANA) then
        consoleCmd("@SetGameVar('"..hero.."_BLOODY_MANA', '1')")
    end
end)

CombatConnection.combat_scripts_paths['bloody_mana'] = '/scripts/Common/combat/Skills/BloodyMana/script.lua'
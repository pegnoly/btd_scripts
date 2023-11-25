HERO_SKILL_BLOODY_SACRIFICE = 222

bloody_sacrifice = {
    active_for_hero = {},
    voice_of_rage_active_for_hero = {},
    power_of_blood_active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_RMG_bloody_sacrifice_add_hero",
function(hero)
    bloody_sacrifice.active_for_hero[hero] = nil
    if Hero.Params.Town(hero) ~= TOWN_STRONGHOLD then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not bloody_sacrifice.active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_BLOODY_SACRIFICE) then
                        bloody_sacrifice.active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_SACRIFICE', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_BLOODY_SACRIFICE) then
                        bloody_sacrifice.active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_BLOODY_SACRIFICE', '')")
                    end
                end
            end
            sleep()
        end 
    end)
end)

AddHeroEvent.AddListener("BTD_RMG_bloody_sacrifice_voice_of_rage_add_hero",
function(hero)
    bloody_sacrifice.voice_of_rage_active_for_hero[hero] = nil
    if Hero.Params.Town(hero) ~= TOWN_STRONGHOLD then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not bloody_sacrifice.voice_of_rage_active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_VOICE_OF_RAGE) then
                        bloody_sacrifice.voice_of_rage_active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_VOICE_OF_RAGE', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_VOICE_OF_RAGE) then
                        bloody_sacrifice.voice_of_rage_active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_VOICE_OF_RAGE', '')")
                    end
                end
            end
            sleep()
        end 
    end)
end)

AddHeroEvent.AddListener("BTD_RMG_bloody_sacrifice_power_of_blood_add_hero",
function(hero)
    bloody_sacrifice.power_of_blood_active_for_hero[hero] = nil
    if Hero.Params.Town(hero) ~= TOWN_STRONGHOLD then
        return
    end
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not bloody_sacrifice.power_of_blood_active_for_hero[%hero] then
                    if HasHeroSkill(%hero, HERO_SKILL_POWER_OF_BLOOD) then
                        bloody_sacrifice.power_of_blood_active_for_hero[%hero] = 1
                        consoleCmd("@SetGameVar('"..%hero.."_POWER_OF_BLOOD', '1')")
                    end
                else
                    if not HasHeroSkill(%hero, HERO_SKILL_POWER_OF_BLOOD) then
                        bloody_sacrifice.power_of_blood_active_for_hero[%hero] = nil
                        consoleCmd("@SetGameVar('"..%hero.."_POWER_OF_BLOOD', '')")
                    end
                end
            end
            sleep()
        end 
    end)
end)

RespawnHeroEvent.AddListener("BTD_RMG_bloody_sacrifice_respawn_hero_event",
function(hero)
    if HasHeroSkill(hero, HERO_SKILL_BLOODY_SACRIFICE) then
        consoleCmd("@SetGameVar('"..hero.."_BLOODY_SACRIFICE', '1')")
    end
    if HasHeroSkill(hero, HERO_SKILL_VOICE_OF_RAGE) then
        consoleCmd("@SetGameVar('"..hero.."_VOICE_OF_RAGE', '1')")
    end   
    if HasHeroSkill(hero, HERO_SKILL_POWER_OF_BLOOD) then
        consoleCmd("@SetGameVar('"..hero.."_POWER_OF_BLOOD', '1')")
    end   
end)

CombatConnection.combat_scripts_paths['bloody_sacrifice'] = '/scripts/Common/combat/Skills/BloodySacrifice/script.lua'
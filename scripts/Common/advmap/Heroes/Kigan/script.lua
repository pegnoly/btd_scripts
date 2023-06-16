kigan_spec_common = 
{
    heroes = {"Hero9", "Hero91", "Hero92"},
    voice_level_for_hero = {}
}

AddHeroEvent.AddListener("BTD_common_kigan_spec_add_hero",
function(hero)
    if not contains(kigan_spec_common.heroes, hero) then
        return
    end
    kigan_spec_common.voice_level_for_hero[hero] = -1
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                local mastery = GetHeroSkillMastery(%hero, HERO_SKILL_VOICE)
                if mastery ~= kigan_spec_common.voice_level_for_hero[%hero] then
                    kigan_spec_common.voice_level_for_hero[%hero] = mastery
                    consoleCmd("@SetGameVar('"..%hero.."_VOICE_MASTERY', "..mastery..")")
                end
            end
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_Common_kigan_spec_respawn_hero",
function(hero)
    if contains(kigan_spec_common.heroes, hero) then
        local mastery = GetHeroSkillMastery(hero, HERO_SKILL_VOICE)
        consoleCmd("@SetGameVar('"..hero.."_VOICE_MASTERY', "..mastery..")")
    end
end)

CombatConnection.combat_scripts_paths['Kigan_spec'] = '/scripts/Common/combat/Heroes/Kigan/script.lua'
biara_spec_common =
{
    heroes = {"Biara", "Biara1", "Biara2"},
    dark_mastery_by_hero = {}
}

AddHeroEvent.AddListener("BTD_Common_biara_spec_add_hero",
function(hero)
    if not contains(biara_spec_common.heroes, hero) then
        return
    end
    biara_spec_common.dark_mastery_by_hero[hero] = -1
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                local mastery = GetHeroSkillMastery(%hero, SKILL_DARK_MAGIC)
                if mastery ~= biara_spec_common.dark_mastery_by_hero[%hero] then
                    biara_spec_common.dark_mastery_by_hero[%hero] = mastery
                    consoleCmd("@SetGameVar('"..%hero.."_DARK_MAGIC_MASTERY', "..mastery..")")
                end
            end
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_Common_biara_spec_respawn_hero",
function(hero)
    if contains(biara_spec_common.heroes, hero) then
        local mastery = GetHeroSkillMastery(hero, SKILL_DARK_MAGIC)
        consoleCmd("@SetGameVar('"..hero.."_DARK_MAGIC_MASTERY', "..mastery..")")
    end
end)

CombatConnection.combat_scripts_paths['Biara_spec'] = '/scripts/Common/combat/Heroes/Biara/script.lua'
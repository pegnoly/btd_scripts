function KiganSpecReload()
    for i, hero in GetObjectNamesByType("HERO") do
        local mastery = GetHeroSkillMastery(hero, HERO_SKILL_VOICE)
        consoleCmd("@SetGameVar('"..hero.."_VOICE_MASTERY', "..mastery..")")
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['Kigan_spec'] = '/scripts/Common/combat/Heroes/Kigan/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_kigan_spec_reload', KiganSpecReload)")
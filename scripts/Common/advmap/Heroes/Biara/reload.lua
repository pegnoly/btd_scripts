function BiaraSpecReload()
    for i, hero in GetObjectNamesByType("HERO") do
        local mastery = GetHeroSkillMastery(hero, SKILL_DARK_MAGIC)
        consoleCmd("@SetGameVar('"..hero.."_DARK_MAGIC_MASTERY', "..mastery..")")
    end
end


consoleCmd("@CombatConnection.combat_scripts_paths['Biara_spec'] = '/scripts/Common/combat/Heroes/Biara/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_biara_spec_reload', BiaraSpecReload)")
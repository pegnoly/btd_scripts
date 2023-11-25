function BloodySacrificeReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, HERO_SKILL_BLOODY_SACRIFICE) then
            consoleCmd("@SetGameVar('"..hero.."_BLOODY_SACRIFICE', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['bloody_sacrifice'] = '/scripts/Common/combat/Skills/BloodySacrifice/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_bloody_sacrifice_reload', BloodySacrificeReload)")
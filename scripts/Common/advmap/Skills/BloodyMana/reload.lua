function BloodyManaReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, HERO_SKILL_BLOODY_MANA) then
            consoleCmd("@SetGameVar('"..hero.."_BLOODY_MANA', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['bloody_mana'] = '/scripts/Common/combat/Skills/BloodyMana/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_bloody_mana_reload', BloodyManaReload)")
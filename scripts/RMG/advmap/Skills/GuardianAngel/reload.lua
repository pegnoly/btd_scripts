-- [#3 fix] 
function GuardianAngelReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, KNIGHT_FEAT_GUARDIAN_ANGEL) then
            consoleCmd("@SetGameVar('"..hero.."_GUARDIAN_ANGEL', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['guardian_angel_rmg'] = '/scripts/RMG/combat/Skills/GuardianAngel/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_guardian_angel_reload', GuardianAngelReload)")
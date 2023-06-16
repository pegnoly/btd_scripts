-- [#3 fix] 
function SorceryDefenceReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, 221) then
            consoleCmd("@SetGameVar('"..hero.."MAG_DEF', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['sorcery_defence'] = '/scripts/Common/combat/Skills/SorceryDefence/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_sorcery_defence_reload', SorceryDefenceReload)")
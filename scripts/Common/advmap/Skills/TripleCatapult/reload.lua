-- [#3 fix] 
function TripleCatapultReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if hero and alive and HasHeroSkill(hero, DEMON_FEAT_TRIPLE_CATAPULT) then
            consoleCmd("@SetGameVar('"..hero.."_TRIPLE_CATAPULT', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['triple_catapult'] = '/scripts/Common/combat/Skills/TripleCatapult/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_triple_catapult_reload', TripleCatapultReload)")
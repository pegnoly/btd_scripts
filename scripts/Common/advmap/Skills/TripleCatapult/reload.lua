-- [#3 fix] 
function TripleCatapultReload()
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive and HasHeroSkill(hero, 221) then
            consoleCmd("@SetGameVar('"..hero.."MAG_DEF', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['triple_catapult'] = '/scripts/Common/combat/Skills/TripleCatapult/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_triple_catapult_reload', TripleCatapultReload)")
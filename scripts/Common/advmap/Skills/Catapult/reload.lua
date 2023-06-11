-- [#3 fix] 
function CatapultReload()
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive and HasHeroSkill(hero, PERK_CATAPULT) then
            consoleCmd("@SetGameVar('"..hero.."_CATAPULT', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['catapult_common'] = '/scripts/Common/combat/Skills/Catapult/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_catapult_reload', CatapultReload)")
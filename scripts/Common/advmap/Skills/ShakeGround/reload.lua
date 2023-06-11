-- [#3 fix] 
function ShakeGroundReload()
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive and HasHeroSkill(hero, WARLOCK_FEAT_SHAKE_GROUND) then
            consoleCmd("@SetGameVar('"..hero.."_SHAKE_GROUND', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['shake_ground'] = '/scripts/Common/combat/Skills/ShakeGround/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_shake_ground_reload', ShakeGroundReload)")
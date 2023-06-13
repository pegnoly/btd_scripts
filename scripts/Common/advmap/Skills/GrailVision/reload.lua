-- [#3 fix] 
function GrailVisionReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasHeroSkill(hero, KNIGHT_FEAT_GRAIL_VISION) then
            consoleCmd("@SetGameVar('"..hero.."_GRAIL_VISION', '1')")
        end
    end
end

consoleCmd("@CombatConnection.combat_scripts_paths['grail_vision'] = '/scripts/Common/combat/Skills/GrailVision/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_grail_vision_reload', GrailVisionReload)")
twisting_neither = {
    active_for_hero = {}
}

AddHeroEvent.AddListener("BTD_twisting_neither_add_hero", 
function(hero)
    twisting_neither.active_for_hero[hero] = nil
    startThread(
    function()
        while 1 do
            if IsHeroAlive(%hero) then
                if not twisting_neither.active_for_hero[%hero] then
                    if HasArtefact(%hero, ARTIFACT_TWISTING_NEITHER, 1) then
                        consoleCmd("@SetGameVar('"..%hero.."_TWISTING_NEITHER', 'active')")
                        twisting_neither.active_for_hero[%hero] = 1
                    end
                else
                    if not HasArtefact(%hero, ARTIFACT_TWISTING_NEITHER, 1) then
                        consoleCmd("@SetGameVar('"..%hero.."_TWISTING_NEITHER', '')")
                        twisting_neither.active_for_hero[%hero] = nil
                    end
                end
            end  
            sleep()
        end
    end)
end)

RespawnHeroEvent.AddListener("BTD_twisting_neither_respawn_hero",
function(hero)
    if HasArtefact(hero, ARTIFACT_TWISTING_NEITHER, 1) then
        consoleCmd("@SetGameVar('"..hero.."_TWISTING_NEITHER', 'active')")
    end
end)

CombatConnection.combat_scripts_paths['twisting_neither'] = '/scripts/Common/combat/Artifacts/TwistingNeither/script.lua'
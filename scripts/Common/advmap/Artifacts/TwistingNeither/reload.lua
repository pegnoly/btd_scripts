function TwistingNeitherReload()
    for i, hero in GetObjectNamesByType("HERO") do
        if HasArtefact(hero, ARTIFACT_TWISTING_NEITHER, 1) then
            consoleCmd("@SetGameVar('"..hero.."_TWISTING_NEITHER', 'active')")
        end
    end
end


consoleCmd("@CombatConnection.combat_scripts_paths['twisting_neither'] = '/scripts/Common/combat/Artifacts/TwistingNeither/script.lua'")
consoleCmd("@MapReloadEvent.AddListener('BTD_common_twisting_neither_reload', TwistingNeitherReload)")
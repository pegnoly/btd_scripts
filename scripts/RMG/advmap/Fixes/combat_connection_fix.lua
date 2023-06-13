-- [#3 fix] Restores combat scripts paths after reload
function CombatConnectionReload()
    CombatConnection.CreateCombatFunctionsList(CombatConnection.combat_scripts_paths)
end

consoleCmd("@MapReloadEvent.AddListener('BTD_RMG_reload_combat_connection', CombatConnectionReload)")
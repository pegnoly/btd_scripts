
------------------------ ивенты результатов боя --------------------------------
CombatResultsEvent.AddListener('post_combat_fix_event',
function(fight_id)
  local winner = GetSavedCombatArmyHero(fight_id, 1)
  local loser = GetSavedCombatArmyHero(fight_id, 0)
  -- после боев вручную в хотсите необходимо запускать сигнал на срабатывание PostCombatFix-ивентов, т.к. существует проблема, 
  -- что при завершении боя в этом случае игра пытается запустить функции глобальной карты еще находясь в боевом режиме, не обнаруживает их и выдает ошибку
  if winner then
    local winner_owner = GetObjectOwner(winner)
    consoleCmd("@if GetGameVar('MCCS_IsHotseat') == 'true' and GetGameVar('"..winner_owner.."_combat_mode') == 'real' then SetGameVar('"..winner_owner.."_combat_mode', 'auto') SetGameVar('"..winner_owner.."_post_combat_fix_active', '"..winner.."') end")
  end
  if loser then
    consoleCmd("@ local loser_owner = GetGameVar('"..loser.."_owner') if GetGameVar('MCCS_IsHotseat') == 'true' and GetGameVar(loser_owner..'_combat_mode') == 'real' then SetGameVar(loser_owner..'_combat_mode', 'auto') SetGameVar(loser_owner..'_post_combat_fix_active', '"..loser.."')end")
  end
end)

----------------------- ивенты загрузки карты ----------------------------------
-- AddEvent(map_loading_events, 'mccs_files_load_event',
-- function()
  -- --
  -- if MCCS_DEFAULT_SETTINGS.use_new_arts == 1 then
    -- doFile("/scripts/NAF/Halfer__Everyday.lua")
    -- doFile("/scripts/NAF/Halfer__Equip_Loop.lua")
    -- doFile("/scripts/NAF/Halfer_AB.lua")
	-- --doFile('/scripts/NAF/Gerter_Base.lua')
    -- doFile('/scripts/NAF/Gerter_DordalSetFuncs.lua')
    -- doFile('/scripts/NAF/Gerter_Soulbinder.lua')
    -- doFile('/scripts/NAF/Gerter_SarUrazirScepter.lua')
    -- doFile('/scripts/NAF/Gerter_OthersideVeil.lua')
    -- doFile('/scripts/NAF/Gerter_Woodcutter.lua')
    -- doFile('/scripts/NAF/Gerter_Other.lua')
    -- doFile('/scripts/NAF/Gerter_ElementalSphere.lua')
    -- doFile('/scripts/NAF/Gerter_CircleArchive.lua')
    -- doFile('/scripts/NAF/Gerter_CrownOfPrimalEnergy.lua')
  -- end
  -- --
  -- if MCCS_DEFAULT_SETTINGS.nhf_enabled == 1 then
    -- doFile('/scripts/NHF_local_load.lua')
  -- end
-- end)

-- ------------------------ ивенты добавления героев -------------------------
-- AddEvent(add_hero_events, 'mccs_event_init_up_arts',
-- function(hero)
  -- if MCCS_DEFAULT_SETTINGS.use_up_arts == 1 then
    -- up_arts_queue_for_hero[hero] = {}
  -- end
-- end)
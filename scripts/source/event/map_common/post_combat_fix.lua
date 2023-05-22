post_combat_events = {}

function AddPostCombatEvent(desc, func)
  post_combat_events[desc] = func
end

function PostCombatFixInit()
  if not PostCombatFixThread then
     while not PostCombatFixThread do
       sleep()
     end
  end
  for player = PLAYER_1, PLAYER_8 do
    if Player.IsActive(player) then
      consoleCmd("@SetGameVar('"..player.."_game_mode', 'auto')")
      consoleCmd("@SetGameVar('"..player.."_post_combat_fix_active', 'false')")
      consoleCmd("@startThread(PostCombatFixThread, "..player..")")
    end
  end
end

function PostCombatFixThread(player)
  while 1 do
    if GetGameVar(player..'_post_combat_fix_active') ~= 'false' then
      local check_hero = GetGameVar(player..'_post_combat_fix_active')
	    local fight_id = GetLastSavedCombatIndex()
      SetGameVar(player..'_post_combat_fix_active', 'false')
      --
      print('hero: ', check_hero)
      for desc, event in post_combat_events do
        event(check_hero, fight_id)
      end
--      -- временный фикс, добавить post_combat ивенты
--      if MCCS_DEFAULT_SETTINGS.use_new_arts == 1 then
--        if NAF_GetComplexArtUpgrade(check_hero, TENEGORN_SCALES_PRESET) > 0 then
--          print('checking ts lvl')
--          NAF_TenegornScalesAfterFightCheck(check_hero)
--        end
--        --
--        NAF_DordalSetCheckIdolRemoveAfterFight()
--  		--
--    		if HasArtefact(check_hero, ARTIFACT_BELKET_STAFF, 1) then
--    		  consoleCmd("@local army = parse(GetGameVar('"..check_hero.."_belket_staff_army'))() if army ~= '' then startThread(NAF_BelketStaffCheckDead, '"..check_hero.."', army, "..fight_id..") end")
--    		end
--      end
--      --
--      if check_hero == 'Halmogar' then
--        consoleCmd("@if spec_bers_adv then local lvl = GetGameVar('"..check_hero.."_bers_curr_lvl') startThread(SpecBersCheckLvlForHero, '"..check_hero.."', lvl) end")
--      end
--      --
--      if check_hero == 'Demrog' then
--        consoleCmd("@if patience_spec_adv then local def = GetGameVar('"..check_hero.."_patience_def') startThread(PatienceSpecAddDef, '"..check_hero.."', def) SetGameVar('"..check_hero.."_patience_def', 0) end")
--      end
--      --
--      if check_hero == 'Gornara' then
--        consoleCmd("@if shamans_spec_adv then local income = GetGameVar('"..check_hero.."_shamans_income') startThread(ShamansSpec_AddShamans, '"..check_hero.."', income) end")
--      end
    end
    sleep()
  end
end
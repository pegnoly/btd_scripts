do
  local oldSetHeroesExpCoef = SetHeroesExpCoef
  --- Устанавливает коэффициент опыта на для героев(с учетом поправки на сложность)
  ---@param coef number коэффициент
  function SetHeroesExpCoef(coef)
    for i, exp_diff in diff_exp_coeffs do
      exp_diff = exp_diff * coef
    end
    %oldSetHeroesExpCoef(coef)
  end
end

do
  local oldGetObjectOwner = GetObjectOwner
  --- Возвращает владельца объекта, с поправкой на то, что может проверяться герой в городе
  ---@param object string имя объекта
  ---@return PlayerID player номер игрока
  function GetObjectOwner(object)
  	if IsHeroAlive(object) then
  	  object = GetHeroTown(object) or object
  	end
  	local answer = %oldGetObjectOwner(object)
  	return answer
  end
end

do
  local oldMessageBoxForPlayers = MessageBoxForPlayers
  --- MessageBox, адаптированный под мультиплеер
  ---@param player PlayerID номер игрока
  ---@param msg string путь к сообщению
  ---@param func function колбек
  function MCCS_MessageBoxForPlayers(player, msg, func)
    UnblockGame()
    while (GetCurrentPlayer() ~= player)and(GetCurrentPlayer() ~= -1) do
			if GetPlayerState(player) ~= 1 then
				break
			end
			sleep()
			UnblockGame()
		end;
		if (GetPlayerState(player) == 1) then
      %oldMessageBoxForPlayers(GetPlayerFilter(player), msg)
			UnblockGame()
		end;
		UnblockGame()
  end
end

do
  local oldQuestionBox = QuestionBox
  --- Адаптированный QuestionBox
  ---@param msg string путь к сообщению
  ---@return boolean is_ok было нажато ок/отмена
  function MCCS_QuestionBox(msg)
    qbox_answer = -1
    %oldQuestionBox(msg, 'Yes', 'No')
    while qbox_answer == -1 do
      sleep()
    end
    return qbox_answer == 1
  end

  local oldQuestionBoxForPlayers = QuestionBoxForPlayers
  --- Адаптированный QuestionBox для мультиплеера
  ---@param player PlayerID номер игрока
  ---@param msg string путь к сообщению
  ---@return boolean is_ok было нажато ок/отмена
  function MCCS_QuestionBoxForPlayers(player, msg)
    qbox_answer = -1
    %oldQuestionBoxForPlayers(GetPlayerFilter(player), msg, 'Yes', 'No')
    while qbox_answer == -1 do
      sleep()
    end
    return qbox_answer == 1
  end
  --- NHF-адаптированный QuestionBox
  ---@param id_player PlayerID номер игрока
  ---@param path string путь к сообщению
  ---@param f_yes function колбек кнопки ок
  ---@param f_no function колбек кнопки отмена
  function NHF_QuestionBoxForPlayers (id_player,path,f_yes,f_no)
  	UnblockGame();
  	if IsAIPlayer(id_player) ~= 1 then
  		while (GetCurrentPlayer() ~= id_player)and(GetCurrentPlayer() ~= -1) do
  			if GetPlayerState(id_player) ~= 1 then
  				break;
  			end;
  			sleep(1);
  			UnblockGame();
  		end;
  		if (GetPlayerState(id_player) == 1) then
  			%oldQuestionBoxForPlayers(GetPlayerFilter(id_player),path,f_yes,f_no);
  			UnblockGame();
  		end;
  		UnblockGame();
  	end;
  end

  function Yes()
    qbox_answer = 1
  end

  function No()
    qbox_answer = 0
  end
end

do
  local oldShowFlyingSign = ShowFlyingSign
  --- Адаптированный под мультиплеер ShowFlyingSign
  ---@param msg string путь к сообщению
  ---@param object string объект, над которым будет выведено сообщение\
  ---@param player PlayerID номер игрока
  ---@param time number время вывода
  function ShowFlyingSign(msg, object, player, time)
    if IsHeroAlive(object) then
      object = GetHeroTown(object) or object
    end
    if GetCurrentPlayer() ~= -1 then
      while GetCurrentPlayer() ~= player do
        sleep()
      end
    end
    %oldShowFlyingSign(msg, object, player, time)
    UnblockGame()
  end
end

--- MCCS-адаптированный StartCombat
---@param hero string герой, начавший битву
---@param enemy string|boolean герой-противник или nil, если нейтралы
---@param stack_count number число стеков
---@param stacks_info number[] таблица существ/численности
---@param is_diff_independed boolean зависит ли численность стеков от сложности
---@param script string|nil путь к скрипту/nil, если его нет
---@param arena string|nil путь к файлу арены/nil
---@param is_auto_combat boolean автобой/нет
---@return boolean did_win победил ли в битве герой, который ее начал
function MCCS_StartCombat(hero, enemy, stack_count, stacks_info, is_diff_independed, script, arena, is_auto_combat)
  local fight_ID = GetLastSavedCombatIndex()
  local coef = diffCoeffs[defaultDifficulty]-- коэффициент сложности
  local args = {}
  local index = 1
  for i = 1, len(stacks_info) - 1, 2 do
    args[index] = stacks_info[i]
    print("<color=red>MCCS_StartCombat: <color=green> stack - ", args[index])
    args[index + 1] = is_diff_independed and stacks_info[i + 1] or ceil(stacks_info[i + 1] * coef)
    print("<color=red>MCCS_StartCombat: <color=green> count - ", args[index + 1])
    index = index + 2
  end
  args[index + 2] = script
  args[index + 3] = arena
  args[index + 4] = is_auto_combat
  local floor_flag
  -- если заданы соотв. параметры, может менять освещение на арене
  if IsInDungeon(hero) and COMBAT_LIGHTS then
    SetCombatLight(COMBAT_LIGHTS.UGROUND)
    floor_flag = 1
  end
  print("<color=red>MCCS_StartCombat: <color=green> ready to fight?")
  StartCombat(hero, enemy, stack_count, args[1], args[2], args[3], args[4], args[5], args[6], args[7],
                                        args[8], args[9], args[10], args[11], args[12], args[13], args[14],
                                        args[15], args[16], args[17], args[18])
  while GetLastSavedCombatIndex() == fight_ID do sleep() end
  if floor_flag then
    SetCombatLight(COMBAT_LIGHTS.CURRENT)
  end
  local result = IsHeroAlive(hero)
  return result
end

--- Возвращает объекты заданного типа в регионе
---@param region string имя региона
---@param type string тип объектов
---@return table objects найденные объекты
function GetObjectsInRegion(region, type)
  local answer, n = {}, 0
  for i, object in GetObjectNamesByType(type) do
    if IsObjectInRegion(object, region) then
      if not (type == 'HERO' and contains(decorativePlayers, GetObjectOwner(object))) then
        n = n + 1
        answer[n] = object
      end
    end
  end
  return answer
end
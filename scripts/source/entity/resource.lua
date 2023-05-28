Resource =
{
  Exception =
  function(ex)
    print("Resource.Exception: ", ex)
  end,
  
  IsEnough =
  --- Определяет наличие ресурса у игрока
  ---@param player PlayerID id игрока
  ---@param res_type ResourceType тип ресурса
  ---@param num integer число ресурса
  ---@return boolean is_enough есть ресурс/нет
  function(player, res_type, num)
    errorHook(
    function()
      Resource.Exception("checking res "..%res_type.." for player "..%player.." in count of "..%num)
    end)
    local answer
    if GetPlayerResource(player, res_type) >= num then
      answer = 1
    else
      answer = nil
    end
    return answer
  end,

  IsEnoughT =
  --- Определяет наличие ресурсов у игрока, заданных таблицей
  ---@param player PlayerID id игрока
  ---@param res_table table<ResourceType, integer> таблица ресурсов
  ---@return boolean is_enough есть ресусы/нет
  function(player, res_table)
    errorHook(
    function()
      Resource.Exception("checking res table"..%res_table.." for player "..%player)
    end)
    local answer = 1
    for res, amount in res_table do
      if not Resource.IsEnough(player, res, amount) then
        answer = nil
      end
    end
    return answer
  end,

  Remove =
  --- Убирает ресурс у игрока
  ---@param player PlayerID id игрока
  ---@param res_type ResourceType тип ресурса
  ---@param num integer число ресурса
  ---@return boolean is_removed успешно убран/нет
  function(player, res_type, num)
    errorHook(
    function()
      Resource.Exception("removing res "..%res_type.." for player "..%player.." in count of "..%num)
    end)
    local answer
    if Resource.IsEnough(player, res_type, num) then
      SetPlayerResource(player, res_type, GetPlayerResource(player, res_type) - num)
      answer = 1
    else
      answer = nil
    end
    return answer
  end,

  RemoveT =
  --- Удаляет ресурсы у игрока, заданные таблицей
  ---@param player PlayerID id игрока
  ---@param res_table table<ResourceType, integer> таблица ресурсов
  ---@return boolean are_removed успешно убраны/нет
  function(player, res_table)
    errorHook(
    function()
      Resource.Exception("removing res table"..%res_table.." for player "..%player)
    end)
    local answer = 1
    if not Resource.IsEnoughT(player, res_table) then
      answer = nil
    else
      for res, amount in res_table do
        Resource.Remove(player, res, amount)
      end
    end
    return answer
  end,

  Change =
  --- Обертка над изменением числа ресурса
  ---@param hero string имя героя
  ---@param res_type ResourceType тип ресурса
  ---@param num integer число ресурса
  function(hero, res_type, num)
    errorHook(
    function()
      Resource.Exception("changing "..%res_type.." for hero "..%hero.." in count of "..%num)
    end)
    local player = GetObjectOwner(hero)
    local colors =
    {
       [1] = "/Text/Game/Player/Colors/green_color.txt",
       [2] = "/Text/Game/Player/Colors/red_color.txt"
    }
    local color = ''
    local sign = ''
    if num < 0 then
      color = colors[2]
    else
      color = colors[1]
      sign = rtext('+')
    end
    SetPlayerResource(player, res_type, GetPlayerResource(player, res_type) + num)
    MessageQueue.AddMessage(player, {'/Text/Default/add_res.txt'; res = ResNames[res_type], color = color, sign = sign, count = num}, hero, 6.0)
  end
}
Player = 
{
  IsActive =
  --- Возвращает, является ли активным игрок
  ---@param player PlayerID номер игрока
  ---@return boolean is_active активен ли игрок
  function(player)
    return GetPlayerState(player) == PLAYER_ACTIVE
  end,

  GetTowns =
  --- Возвращает таблицу городов, принадлежащих игроку
  ---@param player PlayerID номер игрока
  ---@return table|nil towns таблица городов
  function(player)
    local answer, n = {}, 0
    for i, town in GetObjectNamesByType('TOWN') do
      if GetObjectOwner(town) == player then
        n = n + 1
        answer[n] = town
      end
    end
    if length(answer) == 0 then
      return nil
    else
      return answer
    end
  end
}
MessageQueue =
{
  [PLAYER_1] = {},
  [PLAYER_2] = {},
  [PLAYER_3] = {},
  [PLAYER_4] = {},
  [PLAYER_5] = {},
  [PLAYER_6] = {},
  [PLAYER_7] = {},
  [PLAYER_8] = {},

  AddMessage =
  ---Добавляет сообщение в очередь для игрока
  ---@param player PlayerID id игрока
  ---@param message string путь к сообщению
  ---@param object string объект, над которым будет выведено сообщение
  ---@param delay number длительность вывода
  function(player, message, object, delay)
    local length = len(MessageQueue[player])
    MessageQueue[player][length + 1] = {msg = message, obj = object, delay = delay, index = length + 1}
  end,

  RemoveMessage =
  ---Удаляет сообщение из очереди игрока по индексу
  ---@param player PlayerID id игрока
  ---@param index number индекс сообщения в очереди
  function(player, index)
    MessageQueue[player][index] = nil
  end,

  Run =
  ---@meta
  function(player)
    while 1 do
      local msg_info = MessageQueue[player][1]
      if msg_info then
        print(msg_info.msg)
        MessageQueue.RemoveMessage(player, 1)
        for j = 2, len(MessageQueue[player]) + 1 do
          MessageQueue[player][j - 1] = MessageQueue[player][j]
        end
        MessageQueue[player][len(MessageQueue[player])] = nil
        --
        ShowFlyingSign(msg_info.msg, msg_info.obj, player, 5.0)
        sleep(msg_info.delay)
      end
      sleep()
    end
  end
}
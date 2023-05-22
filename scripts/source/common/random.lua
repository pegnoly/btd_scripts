---@alias RandomType
---|`Random.Random_ADV_MAP` # рандом карты приключений
---|`Random.Random_COMBAT` # рандом комбата
RANDOM_ADV_MAP_MODE = "Random_ADV_MAP"
RANDOM_COMBAT_MODE = "Random_COMBAT"

Random =
{
  Exception =
  function(info)
    print("<color=red>Random.Exception: <color=red>", info)
  end,

  Mode =
  --- Возвращает текущий тип рандома
  ---@return RandomType typ тип рандома
  function()
    errorHook(
    function()
       Random.Exception("mode")
    end)
    local answer = random(1) == 1 and RANDOM_COMBAT_MODE or RANDOM_ADV_MAP_MODE
    return answer
  end,

  FromSelection =
  --- Возвращает случайное значение из заданных
  ---@param ... any возможные значения
  ---@return any|nil value случайное значение
  function(...)
    errorHook(
    function()
       Random.Exception("selection")
    end)
    if arg.n == 0 then
      return nil
    end
    if arg.n == 1 then
      return arg[1]
    end
    local answer = 0
    local Random_mode = Random.Mode()
    answer = random(arg.n) + 1 * (Random_mode == RANDOM_ADV_MAP_MODE and 1 or 0)
    for i = 1, arg.n do
      if answer == i then
        answer = arg[i]
        return answer
      end
    end
    return nil
  end,

  FromSelection_IgnoreValue =
  --- Возвращает случайное значение из заданных, игнорируя другое заданное значение
  ---@param e_val any игнорируемое значение
  ---@param ... any возможные значения
  ---@return any|nil value случайное значение
  function(e_val, ...)
    errorHook(
    function()
       Random.Exception("selection with exceptional value")
    end)
    if arg.n == 0 then
      return nil
    end
    if arg.n == 1 then
      if arg[1] ~= e_val then
        return arg[1]
      else
        print('<color=white>Random.FromSelectionWithExceptionalValue: <color_negative>Only one argument given and it is banned - return nil')
        return nil
      end
    end
    local tbl = {[1] = e_val}
    if table.is_equal(tbl, arg) then
      print('<color=white>Random.FromSelectionWithExceptionalValue: <color_negative>All given arguments are banned - return nil')
      return nil
    end
    --
    local answer, is_ok = nil
    local Random_mode = Random.Mode()
    repeat
      answer = random(arg.n) + 1 * (Random_mode == RANDOM_ADV_MAP_MODE and 1 or 0)
      for i = 1, arg.n do
        if answer == i and arg[i] ~= e_val then
          is_ok = 1
          answer = arg[i]
          return answer
        end
      end
    until is_ok
  end,

  FromSelection_IgnoreTable =
  --- Возвращает случайное значение из заданных, игнорируя значения из заданной таблицы
  ---@param e_tbl <any>[] игнорируемые значения
  ---@param ... any возможные значения
  ---@return any|nil value случайное значение
  function(e_tbl, ...)
    errorHook(
    function()
       Random.Exception("selection with exceptional table")
    end)
    if arg.n == 0 then
      return nil
    end
    if arg.n == 1 then
      if contains(e_tbl, arg[1]) then
        print('<color=white>Random.FromSelectionWithExceptionalTable: <color_negative>Only one argument given and it is banned - return nil')
        return nil
      else
        return arg[1]
      end
    end
    if table.is_equal(e_tbl, arg) then
      print('<color=white>Random.FromSelectionWithExceptionalTable: <color_negative>All given arguments are banned - return nil')
      return nil
    end
    --
    local answer, is_ok = nil
    local Random_mode = Random.Mode()
    repeat
      answer = random(arg.n) + 1 * (Random_mode == RANDOM_ADV_MAP_MODE and 1 or 0)
      for i = 1, arg.n do
        if answer == i and not(contains(e_tbl, arg[i])) then
          is_ok = 1
          answer = arg[i]
          return answer
        end
      end
    until is_ok
  end,

  FromTable =
  --- Возвращает случайное значение из заданной таблицы
  ---@param tbl table заданная таблица
  ---@return any|nil value случайное значение
  function(tbl)
    errorHook(
    function()
       Random.Exception("table")
    end)
    local answer = Random.FromSelection(table.unpack(tbl))
    return answer
  end,

  FromTable_IgnoreValue =
  --- Возвращает случайное значение из заданной таблицы, игнорируя другое заданное значение
  ---@param e_val any игнорируемое значение
  ---@param tbl table заданная таблица
  ---@return any|nil value случайное значение
  function(e_val, tbl)
    errorHook(
    function()
       Random.Exception("table with exceptional value")
    end)
    local answer = Random.FromSelection_IgnoreValue(e_val, table.unpack(tbl))
    return answer
  end,

  FromTable_IgnoreTable =
  --- Возвращает случайное значение из заданной таблицы, игнорируя заданную таблицу значений
  ---@param e_tbl <any>[] игнорируемые значения
  ---@param tbl table заданная таблица
  ---@return any|nil value случайное значение
  function(e_tbl, tbl)
    errorHook(
    function()
       Random.Exception("table with exceptional table")
    end)
    local answer = Random.FromSelection_IgnoreTable(e_tbl, table.unpack(tbl))
    return answer
  end 
}
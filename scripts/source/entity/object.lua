Object = 
{
  Exception =
  function(info)
    print("<color=red>Object.Exception: <color=red>", info)
  end,

  RemoveSelection =
  --- Удаляет заданные объекты
  ---@param ... string объекты
  function(...)
    errorHook(
    function()
      local text = ""
      for i = 1, %arg.n do
        text = text..%arg[i]..", "
      end
      Object.Exception("remove selection: "..text)
    end)
    for i, obj in arg do
      if IsObjectExists(obj) then
        RemoveObject(obj)
      end
    end
  end,

  RemoveTable =
  --- Удаляет заданную таблицу объектов
  ---@param tbl string[] объекты
  function(tbl)
    errorHook(
    function()
       local text = ""
       for i, obj in %tbl do
         text = text..obj..", "
       end
       Object.Exception("remove table: "..text)
    end)
    for i, obj in arg do
      if IsObjectExists(obj) then
        RemoveObject(obj)
      end
    end
  end,

  Show =
  --- Показывает объект игроку
  ---@param player PlayerID id игрока
  ---@param object string имя объекта
  ---@param use_cam boolean использовать камеру при показе
  ---@param move_cam boolean использовать перемещение камеры при показе
  function(player, object, use_cam, move_cam)
    errorHook(
    function()
      Object.Exception("show "..%object.." to player "..%player.." using camera - "..%use_cam..", moving camera - "..%move_cam)
    end)
    use_cam = use_cam or nil
    move_cam = move_cam or nil
    local x, y, z = GetObjectPosition(object)
    OpenCircleFog(x, y, z, 3, player)
    sleep()
    if use_cam then
      if move_cam then
        MoveCamera(x, y, z, 0, 0, 0, 1, 1)
      else
        MoveCamera(x, y, z, 0, 0, 0, 1, 1, 1)
      end
    end
  end,

  Distance =
  --- Находит расстояние между объектами
  ---@param obj1 string первый объект
  ---@param obj2 string второй объект
  ---@return number|nil distance расстояние
  function(obj1, obj2)
    errorHook(
    function()
      Object.Exception("checking distance between "..%obj1.." and "..%obj2)
    end)
    local x1, y1, z1 = GetObjectPosition(obj1)
    local x2, y2, z2 = GetObjectPosition(obj2)
    if z1 ~= z2 then
      -- print('Error: objects are not on same floor!')
      return nil
    end
    local dist1 = x2 - x1
    local dist2 = y2 - y1
    local answer = sqrt(dist1 * dist1 + dist2 * dist2)
    return floor(answer)
  end
}
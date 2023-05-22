Touch = 
{
    handler_tables = {},
    
    DisableMonster = 
    --- Выключает монстра на карте приключений
    ---@param monster string скриптовое имя монстра
    ---@param cursor ObjectInteractionCursorType тип курсора при наведении на монстра
    ---@param selection integer тип выделения монстра
    ---@param name string путь к файлу с новым именем монстра
    function(monster, cursor, selection, name)
      SetObjectEnabled(monster, nil)
      if cursor then
        SetDisabledObjectMode(monster, cursor)
      end
      if selection then
        startThread(
        function()
          sleep()
          SetMonsterSelectionType(%monster, %selection)
        end)
      end
      if name then
        SetMonsterNames(monster, MONSTER_NAME_SINGLE, name)
      end
    end,

    DisableObject = 
    --- Выключает объект на карте приключений
    ---@param object string скриптовое имя объекта
    ---@param cursor ObjectInteractionCursorType тип курсора при наведении на объект
    ---@param name string путь к файлу с новым именем объекта
    ---@param desc string путь к файлу с новым описанием объекта
    function(object, cursor, name, desc)
      SetObjectEnabled(object, nil)
      if cursor then
        SetDisabledObjectMode(object, cursor)
      end
      if name then
        OverrideObjectTooltipNameAndDescription(object, name, desc and desc or 'blank.txt')
      end
    end,

    DisableHero =
    --- Выключает героя на карте приключений
    ---@param hero string скриптовое имя героя
    ---@param cursor ObjectInteractionCursorType тип курсора при наведении на героя
    function(hero, cursor)
      SetObjectEnabled(hero, nil)
      if cursor then
        SetDisabledObjectMode(hero, cursor)
      end
      startThread(
      function()
        while IsObjectEnabled(%hero) do
          sleep()
        end
        print('object: ', %hero)
        local hero_in_town
        while not IsObjectEnabled(%hero) do
          local town = GetHeroTown(%hero)
          if town and not hero_in_town then
            print('town: ', town)
            hero_in_town = 1
            local town_enabled = IsObjectEnabled(town)
            if town_enabled then
              Touch.DisableObject(town)
              print(town, ' disabled')
            end
            for desc, func in Touch.GetHandlersTable(%hero).funcs do
              Touch.SetFunction(town, desc, func)
            end
            while GetHeroTown(%hero) == town do
              sleep()
            end
            hero_in_town = nil
            if town_enabled then
              SetObjectEnabled(town, 1)
            end
            for desc, func in Touch.GetHandlersTable(%hero).funcs do
              Touch.RemoveFunction(town, desc)
            end
          end
          sleep()
        end
      end)
    end,

    SetTrigger = 
    --- Назначает триггер объекту
    ---@param object string скриптовое имя объекта
    function(object)
      if IsHeroAlive(object) then
        Trigger(HERO_TOUCH_TRIGGER, object, 'Touch.CallHandlers')
      else
        Trigger(OBJECT_TOUCH_TRIGGER, object, 'Touch.CallHandlers')
      end
    end,

    ResetTrigger =
    --- Убирает триггер с объекта
    ---@param object any
    function(object)
      if IsHeroAlive(object) then
        Trigger(HERO_TOUCH_TRIGGER, object, nil)
      else
        Trigger(OBJECT_TOUCH_TRIGGER, object, nil)
      end
    end,

    NewHandlersTable = 
    ---@meta
    function(object)
      Touch.handler_tables[object] = {funcs = {}, priority_func = nil}
      Touch.SetTrigger(object)
    end,

    GetHandlersTable =
    ---@meta
    function(object)
      if (not Touch.handler_tables[object]) then
        return nil
      else
        local answer = Touch.handler_tables[object]
        return answer
      end
    end,

    HasFunction =
    --- Определяет, есть ли на объекте функция
    ---@param object string скриптовое имя объекта
    ---@param desc string описание функции
    ---@return boolean has имеет функцию/нет
    function(object, desc)
      local table = Touch.GetHandlersTable(object)
      if not table then
        return nil
      else
        if table.funcs[desc] then
          return 1
        else
          return nil
        end
      end
    end,

    HasAnyFunction =
    --- Определяет, есть ли на объекте хотя бы одна функция
    ---@param object string скриптовое имя объекта
    ---@return boolean has имеется функция/нет
    function(object)
      local table = Touch.GetHandlersTable(object)
      if not table then
        return nil
      else
        if not table.funcs then
          return nil
        end
        for desc, func in table.funcs do
          if desc and func then
            return 1
          end
        end
      end
      return nil
    end,

    HasImportantFunction =
    ---@meta
    function(object)
      local table = Touch.GetHandlersTable(object)
      if not table then
        return nil
      else
        for desc, func in table.funcs do
          if desc then
            local s = string.spread(desc)
            if s[1] == '_' then
              return 1
            end
          end
        end
      end
    end,

    SetFunction =
    --- Назначает функцию объекту
    ---@param object string скриптовое имя объекта
    ---@param desc string имя функции
    ---@param func function функция
    function(object, desc, func)
      local table = Touch.GetHandlersTable(object)
      if table then
        local l = length(table.funcs)
        if l == 0 then
          Touch.SetTrigger(object)
        end
        table.funcs[desc] = func
      else
        Touch.NewHandlersTable(object)
        Touch.handler_tables[object].funcs[desc] = func
      end
      if IsHeroAlive(object) and GetHeroTown(object) then
        startThread(Touch.SetFunction, GetHeroTown(object), desc, func)
      end
    end,

    RemoveFunction =
    --- Удаляет функцию с объекта
    ---@param object string скриптовое имя объекта
    ---@param desc_to_del string имя функции
    function(object, desc_to_del)
      print('<color=red>Touch.<color=green>RemoveFunction: object - ', object, ', desc_to_del - ', desc_to_del)
      local table = Touch.GetHandlersTable(object)
      if table then
        for desc, func in table.funcs do
          if desc == desc_to_del then
            table.funcs[desc] = nil
            break
          end
        end
      end
    end,

    RemoveFunctions =
    --- Удаляет все функции с объекта
    ---@param object string скриптовое имя объекта
    function(object)
      Touch.ResetTrigger(object)
      Touch.handler_tables[object].funcs = {}
      Touch.handler_tables[object].priority_func = nil
    end,

    SetPriorityFunction =
    --- Назначает приоритетную функцию объекту
    ---@param object string скриптовое имя объекта
    ---@param func string имя функции
    function(object, func)
      local table = Touch.GetHandlersTable(object)
      if not table then
        Touch.NewHandlersTable(object)
      end
      Touch.handler_tables[object].priority_func = func
      if IsHeroAlive(object) and GetHeroTown(object) then
        startThread(Touch.SetPriorityFunction, GetHeroTown(object), func)
      end
    end,

    OverrideFunction =
    --- Перезаписывает функцию на объекте
    ---@param object string скриптовое имя объекта
    ---@param desc string имя функции
    ---@param func function функция
    function(object, desc, func)
      Touch.handler_tables[object].funcs[desc] = func
    end,

    CallHandlers =
    function(hero, object)
      -- if IsObjectEnabled(object) then return end
      print('<color=red>Touch.<color=green>CallHandlers: object ', object)
      local answer
      if Touch.handler_tables[object].priority_func then 
        answer = Touch.handler_tables[object].priority_func(hero, object)
        return answer
      end
      local funcs = Touch.handler_tables[object].funcs
      for desc, func in funcs do
        print('<color=red>Touch.<color=green>CallHandlers: call ', desc)
        if desc then
          answer = func(hero, object)
        end
      end
      return answer
    end
}
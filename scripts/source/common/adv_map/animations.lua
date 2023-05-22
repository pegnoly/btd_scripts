---@alias AnimationPlayCondition
--- |`Animation.PLAY_CONDITION_SINGLEPLAY` # Анимация будет проиграна 1 разговоров
--- |`Animation.PLAY_CONDITION_HERO_IN_REGION` # Анимация будет проигрываться, пока в связанном с анигруппой регионе есть активные герои
--- |`Animation.PLAY_CONDITION_OBJECT_EXISTS` # Анимация будет проигрываться, пока объект существует
Animation.PLAY_CONDITION_SINGLEPLAY = 1
Animation.PLAY_CONDITION_HERO_IN_REGION = 2
Animation.PLAY_CONDITION_OBJECT_EXISTS = 3

Animation = 
{
  Groups = {},
  AbortedThreads = {},

  NewGroup =
--- Добавляет новую анимгруппу
---@param name string имя группы
---@param actors table объекты, входящие в группу
---@param region string регион, связанный с группой
  function(name, actors, region)
      region = region or ''
      Animation.Groups[name] = {actors = actors, region = region}
  end,

  RemoveGroup =
--- Удаляет анигруппу по ее имени
---@param name string имя группы
  function(name)
    Animation.Groups[name] = nil
  end,

  PlayGroup =
  ---Проигрывает анимации для группы
  ---@param group string имя группы
  ---@param anims table таблица возможных анимаций
  ---@param cond AnimationPlayCondition условие проигрывания
  ---@param action AnimationActionType тип проигрывания
  ---@param start_delay number стартовая задержка перед проигрыванием
  ---@param play_period number задержка между проигрываниями
  ---@param is_random_delay boolean использовать конкретную задержку или случайное число из этого промежутка
  function(group, anims, cond, action, start_delay, play_period, is_random_delay)
    cond = cond or Animation.PLAY_CONDITION_SINGLEPLAY
    action = action or NON_ESSENTIAL
    start_delay = start_delay or 20
    play_period = play_period or 20
    is_random_delay = is_random_delay or 1
    if cond == Animation.PLAY_CONDITION_SINGLEPLAY then
      for i, actor in Animation.Groups[group].actors do
        startThread(PlayObjectAnimation, actor, Random.FromTable(anims), action)
      end
    elseif cond == Animation.PLAY_CONDITION_HERO_IN_REGION then
      for i, actor in Animation.Groups[group].actors do
        startThread(
        function()
          local actor, anims, region, action, start_delay, play_period, is_random_delay = %actor, %anims, Animation.Groups[%group].region, %action, %start_delay, %play_period, %is_random_delay
          while 1 do
            while length(GetObjectsInRegion(region, 'HERO')) > 0 and not Animation.AbortedThreads[%group] do
              sleep(random(start_delay))
              PlayObjectAnimation(actor, Random.FromTable(anims), action)
              local delay = is_random_delay and (random(play_period) + 10) or play_period
              sleep(delay)
            end
            sleep()
          end
        end)
      end
    elseif cond == Animation.PLAY_CONDITION_OBJECT_EXISTS then
      for i, actor in Animation.Groups[group].actors do
        startThread(
        function()
          local actor, anims, region, action, start_delay, play_period, is_random_delay = %actor, %anims, Animation.Groups[%group].region, %action, %start_delay, %play_period, %is_random_delay
          --sleep(random(start_delay))
          while IsObjectExists(actor) and not Animation.AbortedThreads[%group] do
            PlayObjectAnimation(actor, Random.FromTable(anims), action)
            local delay = is_random_delay == 1 and (random(play_period) + 10) or play_period
            sleep(delay)
          end
        end)
      end
    end
  end,

  AbortThread =
  ---Временно прерывает проигрывание потока анимаций по имени группы
  ---@param group string имя группы
  function(group)
    Animation.AbortedThreads[group] = 1
  end,

  RestoreThread =
  ---Восстанавливает прерванный поток анимаций по имени группы
  ---@param group string имя группы
  function(group)
    Animation.AbortedThreads[group] = nil
  end
}
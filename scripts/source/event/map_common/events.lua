-- ����� ������ ���
NewDayEvent = {}
NewDayEvent.listeners = {}

NewDayEvent.AddListener =
function(desc, func)
  NewDayEvent.listeners[desc] = func
end

NewDayEvent.RemoveListener =
function(desc)
  NewDayEvent.listeners[desc] = nil
end

NewDayEvent.Invoke =
function(day)
  for desc, func in NewDayEvent.listeners do
    startThread(func, day)
  end
end

-- ����� ����������� ���
CombatResultsEvent = {}
CombatResultsEvent.listeners = {}

CombatResultsEvent.AddListener =
function(desc, func)
  CombatResultsEvent.listeners[desc] = func
end

CombatResultsEvent.RemoveListener =
function(desc)
  CombatResultsEvent.listeners[desc] = nil
end

CombatResultsEvent.Invoke =
function(fight_id)
  for desc, func in CombatResultsEvent.listeners do
    startThread(func, fight_id)
  end
end

-- ����� ��������� ������
LevelUpEvent = {}
LevelUpEvent.listeners = {}

LevelUpEvent.AddListener =
function(desc, func)
  LevelUpEvent.listeners[desc] = func
end

LevelUpEvent.RemoveListener =
function(desc)
  LevelUpEvent.listeners[desc] = nil
end

LevelUpEvent.Invoke =
function(hero)
  for desc, func in LevelUpEvent.listeners do
    startThread(func, hero)
  end
end

-- ����� ��������� �����
XpTrackingEvent = {}
XpTrackingEvent.listeners = {}

XpTrackingEvent.AddListener =
function(desc, func)
  XpTrackingEvent.listeners[desc] = func
end

XpTrackingEvent.RemoveListener =
function(desc)
  XpTrackingEvent.listeners[desc] = nil
end

XpTrackingEvent.Invoke =
function(hero, curr_exp, new_exp)
  for desc, func in XpTrackingEvent.listeners do
    startThread(func, hero, curr_exp, new_exp)
  end
end

-- ����� �������� �����
MapLoadingEvent = {}
MapLoadingEvent.listeners = {}

MapLoadingEvent.AddListener =
function(desc, func)
  MapLoadingEvent.listeners[desc] = func
end

MapLoadingEvent.RemoveListener =
function(desc)
  MapLoadingEvent.listeners[desc] = nil
end

MapLoadingEvent.Invoke =
function()
  for desc, func in MapLoadingEvent.listeners do
    print("<color=red>MapLoadingEvent.Invoke: <color=green>", desc)
    startThread(func)
  end
end

-- ����� ��������� �����
AddHeroEvent = {}
AddHeroEvent.listeners = {}

AddHeroEvent.AddListener =
function(desc, func)
  AddHeroEvent.listeners[desc] = func
end

AddHeroEvent.RemoveListener =
function(desc)
  AddHeroEvent.listeners[desc] = nil
end

AddHeroEvent.Invoke =
function(hero)
  for desc, func in AddHeroEvent.listeners do
    print("<color=red>AddHeroEvent.Invoke: <color=green>", desc)
    startThread(func, hero)
  end
end

-- ����� �������� �����
RespawnHeroEvent = {}
RespawnHeroEvent.listeners = {}

RespawnHeroEvent.AddListener =
function(desc, func)
  RespawnHeroEvent.listeners[desc] = func
end

RespawnHeroEvent.RemoveListener =
function(desc)
  RespawnHeroEvent.listeners[desc] = nil
end

RespawnHeroEvent.Invoke =
function(hero)
  for desc, func in RespawnHeroEvent.listeners do
    startThread(func, hero)
  end
end

-- ����� �������� �����
RemoveHeroEvent = {}
RemoveHeroEvent.listeners = {}

RemoveHeroEvent.AddListener =
function(desc, func)
  RemoveHeroEvent.listeners[desc] = func
end

RemoveHeroEvent.RemoveListener =
function(desc)
  RemoveHeroEvent.listeners[desc] = nil
end

RemoveHeroEvent.Invoke =
function(hero)
  for desc, func in RemoveHeroEvent.listeners do
    startThread(func, hero)
  end
end

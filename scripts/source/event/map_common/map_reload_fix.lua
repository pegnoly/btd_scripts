-- ивент перезагрузки карты [3.3]
MapReloadEvent = {}
MapReloadEvent.listeners = {}

MapReloadEvent.AddListener =
function(desc, func)
  MapReloadEvent.listeners[desc] = func
end

MapReloadEvent.RemoveListener =
function(desc)
  MapReloadEvent.listeners[desc] = nil
end

MapReloadEvent.Invoke =
function()
  for desc, func in MapReloadEvent.listeners do
    print("<color=red>MapReloadEvent.Invoke: <color=green>", desc)
    startThread(func)
  end
end

function MapReloadThreadFix()
    print("Here?")
    local stats =
    {
        [STAT_ATTACK] = {name = '_Attack'},
        [STAT_DEFENCE] = {name = '_Defence'},
        [STAT_SPELL_POWER] = {name = '_Spellpower'},
        [STAT_KNOWLEDGE] = {name = '_Knowledge'},
        [STAT_MORALE] = {name = '_Morale'},
        [STAT_LUCK] = {name = '_Luck'},
    }
    for hero, alive in AdvMapHeroesInfo.alive_heroes do
        if hero and alive then
            
end

consoleCmd("@MapReloadEvent.AddListener('test_map_reload', MapReloadThreadFix)")
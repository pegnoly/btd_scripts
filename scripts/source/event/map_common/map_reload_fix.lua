-- [#3 fix] Event will be invoked when script detects that game was reloaded.
-- Requeres global_load & console syntax for listeners.
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
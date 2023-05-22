--- Добавляет отряд существ в армию героя
---@param hero string скриптовое имя героя
---@param creature CreatureID id существа
---@param count integer число существ
---@param slot integer слот в армии (-1 по умолчанию - первый свободный слот)
function AddHeroCreatures(hero, creature, count, slot)
end

--- Добавляет отряд существ в армию объекта
---@param hero string скриптовое имя объекта
---@param creature CreatureID id существа
---@param count integer число существ
---@param slot integer слот в армии (-1 по умолчанию - первый свободный слот)
function AddObjectCreatures(object, creature, count, slot)
end

--- Управляет возможностью найма героев определенной расы в указанном городе
---@param town string скриптовое имя города
---@param race TownType id расы
---@param is_allowed integer 1 - разрешить найм, 0 - запретить
function AllowHeroHiringByRaceInTown(town, race, is_allowed)
end

--- Управляет возможностью найма героев указанных рас (для AI)
---@param player PlayerID id игрока
---@param race TownType id расы
---@param is_allowed integer 1 - разрешить найм, 0 - запретить
function AllowHeroHiringByRaceForAI(player, race, is_allowed)    
end

--- Управляет возможностью найма определенных героев в указанном городе
---@param town string скриптовое имя города
---@param hero string скриптовое имя героя
---@param is_allowed integer 1 - разрешить найм, 0 - запретить
function AllowHiringOfHeroInTown(town, hero, is_allowed)
end

--- Управляет возможностью найма указанных героев (для AI)
---@param player PlayerID id игрока
---@param hero string скриптовое имя героя
---@param is_allowed integer 1 - разрешить найм, 0 - запретить
function AllowHiringOfHeroForAI(player, hero, is_allowed)
end

--- Позволяет запрещать отображение открытых частей карты союзным игрокам
---@param player PlayerID id игрока
---@param ally PlayerID id союзника
---@param is_allowed integer 1 - разрешить отображение, 0 - запретить
function AllowOpenFogOfWarForAlly(player, ally, is_allowed)
end

--- Позволяет запретить появление указанных героев в тавернах, принадлежащих определенному игроку
---@param player PlayerID id игрока
---@param hero string скриптовое имя героя
---@param is_allowed integer 1 - разрешить появление, 0 - запретить
function AllowPlayerTavernHero(player, hero, is_allowed)
end

--- Позволяет запретить появление героев указанной расы в тавернах, которые принадлежат определенному игроку
---@param player PlayerID id игрока
---@param race TownType id расы
---@param is_allowed integer 1 - разрешить появление, 0 - запретить
function AllowPlayerTavernRace(player, race, is_allowed)
end
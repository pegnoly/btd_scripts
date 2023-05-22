--- Выясняет, жив ли герой
---@param hero string скриптовое имя героя
---@return boolean alive жив герой/нет
function IsHeroAlive(hero)
end

--- Выясняет, находится ли герой в настоящее время на корабле
---@param hero string скриптовое имя героя
---@return boolean in_boat на корабле герой/нет
function IsHeroInBoat(hero)
end

--- Проверяет, находится ли указанный герой в определенном городе (с возможностью исследования городских ворот и гарнизона города)
---@param hero string скриптовое имя героя
---@param town string скриптовое имя города
---@param check_gate boolean проверять ворота(1 по умолчанию)
---@param check_garrison boolean проверять гарнизон(1 по умолчанию)
---@return boolean in_town находится в городе/нет
function IsHeroInTown(hero, town, check_gate, check_garrison)
end

--- Определяет, можно ли отобрать у героя артефакты, победив его
---@param hero string скриптовое имя героя
---@return boolean lootable можно отобрать/нет
function IsHeroLootable(hero)
end

--- Определяет, взаимодействует ли интерактивный объект с героем стандартным образом
---@param object string скриптовое имя объекта
---@return boolean enabled объект взаимодействует/нет
function IsObjectEnabled(object)
end

--- Определяет, существует ли данный объект на карте
---@param object string скриптовое имя объекта
---@return boolean exists объект существует/нет
function IsObjectExists(object)
end

--- Определяет, находится ли объект в заданном регионе
---@param object string скриптовое имя объекта
---@param region string скриптовое имя региона
---@return boolean in_region объект в регионе/нет
function IsObjectInRegion(object, region)
end

--- Определяет, отображается ли задание в интерфейсе конкретного игрока
---@param name string скриптовое имя задания
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
---@return boolean visible отображается/нет
function IsObjectiveVisible(name, player)
end

--- Определяет, виден ли объект игроку
---@param player PlayerID id игрока
---@param object string скриптовое имя объекта
---@return boolean visible объект виден/нет
function IsObjectVisible(player, object)
end

--- Выясняет, управляется ли игрок искусственным интеллектом (возвращает 1, если игрок - AI, 0 - если человек)
---@param player PlayerID id игрока
---@return boolean is_ai ии игрок/нет
function IsAIPlayer(player)
end

--- Определяет, заблокирован ли регион для прохождения героями определенного игрока
---@param region string скриптовое имя объекта
---@param player PlayerID id игрока
---@return boolean blocked заблокирован регион/нет
function IsRegionBlocked(region, player)
end

--- Удаляет существ с карты
---@param creature any
function KillMobs(creature)
end

--- Проверяет, проходим ли для героев тайл
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
function IsTilePassable(x, y, floor)
end

--- Проверяет, достижим ли для героя тайл
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
function IsTileReachable(hero, x, y, floor)
end

--- Округляет n в сторону ближайшего целого (пример: intg(4.5) вернёт 5)
---@param n number число
---@return integer res ближайшее целое число
function intg(n)
end

--- Выясняет, будет ли выведен элемент tutorial-а
---@param name string имя элемента
---@return boolean is_enabled будет выведен/нет
function IsTutorialItemEnabled(name)
end

--- Возвращает 1, если на экране присутствует выведенное функцией TutorialMessageBox окно
---@return boolean is_open присутствует/нет
function IsTutorialMessageBoxOpen()
end


--- Разрушает объект на карте
---@param object string скриптовое имя объекта  
function RazeBuilding(object)
end

--- Разрушает город на карте
---@param town string скриптовое имя города  
function RazeTown(town)
end

--- Возвращает координаты региона, состоящего из одной клетки
---@param region string скриптовое имя региона 
---@return number x координата x
---@return number y координата y
---@return MapLevel floor уровень карты
function RegionToPoint(region)
end

--- Забирает артефакт у героя
---@param hero string скриптовое имя героя
---@param artefact ArtifactID id артефакта
function RemoveArtefact(hero, artefact)
end

--- Убирает существ из армии героя
---@param hero string скриптовое имя героя
---@param creature CreatureID id существа
---@param count integer число существ
---@param slot integer слот в армии(-1 по умолчанию - первый подходящий слот)
function RemoveHeroCreatures(hero, creature, count, slot)
end

--- Отнимает у героя машину заданного типа
---@param hero string скриптовое имя героя
---@param type WarMachineType тип машины
function RemoveHeroWarMachine(hero, type)
end

--- Удаляет объект с игровой карты
---@param object string скриптовое имя объекта
function RemoveObject(object)
end

--- Убирает существ из армии объекта
---@param object string скриптовое имя объекта
---@param creature CreatureID id существа
---@param count integer число существ
---@param slot integer слот в армии(-1 по умолчанию - первый подходящий слот)
function RemoveObjectCreatures(object, creature, count, slot)
end

--- Заменяет одно жилище другим жилищем выбранной расы, соответствующей типу существ, которые могут быть наняты в этом жилище
---@param name string скриптовое имя жилища
---@param new_town TownType id новой расы
---@param creature1 CreatureID|nil id первого нового нанимаемого существа
---@param creature2 CreatureID|nil id второго нового нанимаемого существа
---@param creature3 CreatureID|nil id третьего нового нанимаемого существа
---@param creature4 CreatureID|nil id четвертого нового нанимаемого существа
function ReplaceDwelling(name, new_town, creature1, creature2, creature3, creature4)
end

--- Убирает боевой скрипт с героя
---@param hero string скриптовое имя героя
function ResetHeroCombatScript(hero)
end

--- Убирает с объекта карты точечный источник света
---@param object string скриптовое имя объекта
function ResetObjectFlashlight(object)
end

--- Возвращает случайное целое число в диапазоне от 0 до (top-1)
---@param top integer верхнее значение диапазона
---@return integer res случайное число
function random(top)
end

--- Возвращает целую часть числа (пример: round(1.23) вернёт 1)
---@param n number число
---@return integer res целая часть числа
function round(n)
end

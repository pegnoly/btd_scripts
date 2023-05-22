--- Возвращяет существ атакующей стороны
---@return string[] creatures список скриптовых имен существ
function GetAttackerCreatures()
end

---  Возвращяет героя атакующей стороны
---@return string hero скриптовое имя героя
function GetAttackerHero()
end

--- Возвращяет осадную машину атакующей стороны заданного типа
---@param type WarMachineType тип машины
---@return string|nil machine скриптовое имя машины/nil, если машины нет
function GetAttackerWarMachine(type)
end

--- Возвращает осадные машины атакующей стороны
---@return string[] machines список скриптовых имен машин
function GetAttackerWarMachines()
end

--- Возвращает строения заданной стороны боя
---@param side CombatSide сторона боя
---@return string[] machines список скриптовых имен строений
function GetBuildings(side)   
end

--- Возвращает тип строения
---@param building string скриптовое имя здания
---@return CombatBuildingType type тип строения
function GetBuildingType(building)
end

--- Возвращяет количество существ в стеке
---@param creature string скриптовое имя стека существ
---@return integer number число существ
function GetCreatureNumber(creature)
end

--- Возвращает существ заданной стороны боя
---@param side CombatSide сторона боя
---@return string[] creatures список скриптовых имен существ
function GetCreatures(side)
end

--- Возвращяет тип существа
---@param creature string скриптовое имя стека существ
---@return CreatureID type id существа
function GetCreatureType(creature)
end

--- Возвращяет строение защищающейся стороны заданного типа
---@param type CombatBuildingType тип здания
---@return string|nil building скриптовое имя здания|nil, если его нет
function GetDefenderBuilding(type)
end

--- Возвращяет строения защищающейся стороны
---@return string[] buildings список скриптовых имен зданий
function GetDefenderBuildings()
end

--- Возвращяет существ защищающейся стороны
---@return string[] creatures список скриптовых имен существ
function GetDefenderCreatures()
end

--- Возвращяет героя защищающейся стороны
---@return string|nil hero скриптовое имя героя|nil, если его нет
function GetDefenderHero()
end

--- Возвращяет осадную машину защищающейся стороны
---@param type WarMachineType тип машины
function GetDefenderWarMachine(type)
end

--- Возвращяет осадные машины защищающейся стороны
---@return string[] machines список скриптовых имен зданий
function GetDefenderWarMachines()
end

--- Возвращяет имя героя
---@param hero string скриптовое имя героя
---@return string name имя героя
function GetHeroName(hero)
end

--- Возвращает героя заданной строны боя
---@param side CombatSide сторона боя
---@return string hero скриптовое имя героя
function GetHero(side)
end

--- Возвращает текущее количество очков маны юнита
---@param unit string скриптовое имя юнита
---@return integer mp число очков маны
function GetUnitManaPoints(unit)
end

--- Возвращает максимальное количество очков маны юнита
---@param unit string скриптовое имя юнита
---@return integer mp число очков маны
function GetUnitMaxManaPoints(unit)
end

--- Возвращяет координаты юнита на поле боя
---@param unit string скриптовое имя юнита
---@return integer x координата X
---@return integer x координата Y
function GetUnitPosition(unit)
end

--- Возвращает осадные машины заданной стороны боя
---@param side CombatSide сторона боя
---@return string[] machines список скриптовых имен машин
function GetWarMachines(side)
end

--- Возвращает призванные объекты заданной стороны боя
---@param side CombatSide сторона боя
---@return string[] spell_spawns список скриптовых имен обектов
function GetSpellSpawns(side)
end

--- Возвращяет тип осадной машины
---@param machine string скриптовое имя машины
---@return WarMachineType type тип машины
function GetWarMachineType(machine)
end

--- Возвращает, под чьим управлением находится сторона – человека или AI.
---@param side CombatSide сторона боя
---@return CombatHostType host источник управления
function GetHost(side)
end

--- Возвращает призванные объекты атакующей стороны боя
---@return string[] spell_spawns список скриптовых имен обектов
function GetAttackerSpellSpawns()
end

--- Возвращает призванные объекты защищающейся стороны боя
---@return string[] spell_spawns список скриптовых имен обектов
function GetDefenderSpellSpawns()
end
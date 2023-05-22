--- Определяет, принадлежит ли юнит к атакующей стороне
---@param unit string скриптовое имя юнита
---@return boolean is_attacker принадлежит/нет
function IsAttacker(unit)
end

--- Определяет, является ли юнит зданием
---@param unit string скриптовое имя юнита
---@return boolean is_building является/нет
function IsBuilding(unit)
end

--- Определяет управляет ли компьютер указанной стороной боя
---@param side CombatSide сторона боя
---@return boolean is_computer управляется/нет
function IsComputer(side)
end

--- Определяет, является ли юнит существом
---@param unit string скриптовое имя юнита
---@return boolean is_creature является/нет
function IsCreature(unit)
end

--- Определяет, принадлежит ли юнит к защищающейся стороне
---@param unit string скриптовое имя юнита
---@return boolean is_defender принадлежит/нет
function IsDefender(unit)
end

--- Определяет, является ли юнит героем
---@param unit string скриптовое имя юнита
---@return boolean is_hero является/нет
function IsHero(unit)
end

--- Определяет управляет ли человек указанной стороной боя
---@param side CombatSide сторона боя
---@return boolean is_human управляется/нет
function IsHuman(side)
end

--- Определяет, является ли юнит боевой машиной
---@param unit string скриптовое имя юнита
---@return boolean is_machine является/нет
function IsWarMachine(unit)
end

--- Определяет, является ли юнит призванным объектом(кристалл/стенка и т.п.)
---@param unit string скриптовое имя юнита
---@return boolean is_spellspawn является/нет
function IsSpellSpawn(unit)
end


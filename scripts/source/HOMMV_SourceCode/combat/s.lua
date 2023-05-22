--- Установить ATB-значение для юнита
---@param name string скриптовое имя юнита
---@param new_atb number значение ATB
function setATB(name, new_atb)
end

--- Задает режим управления боем для стороны игрока-человека
---@param side CombatSide сторона боя
---@param mode CombatControlMode режим управления
function SetControlMode(side, mode)
end

--- Устанавливает количество очков маны объекта
---@param unit string скриптовое имя юнита
---@param mana integer число очков маны
function SetUnitManaPoints(unit, mana)
end

--- Начало сражения
function Start()
end

--- Добавляет отряд существ на поле боя. Этот отряд НЕ сохранится в армии героя после боя.
---@param side CombatSide сторона боя
---@param creature CreatureID id существа
---@param count integer число существ
---@param x integer координата X(по умолчанию -1 - случайная координата)
---@param y integer координата Y(по умолчанию -1 - случайная координата)
---@param is_summoned boolean 1 - существо будет иметь статус "призван", nil - нет(по умолчанию)
---@param name string скриптовое имя отряда
function SummonCreature(side, creature, count, x, y, is_summoned, name)
end
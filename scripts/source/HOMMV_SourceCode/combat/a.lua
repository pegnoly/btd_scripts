--- Добавляет существо (отряд существ)
---@param creature CreatureID id существа
---@param side CombatSide сторона боя
---@param x integer координата X
---@param y integer координата Y
---@param count integer число существ
---@param name string скриптовое имя отряда
function addUnit(creature, side, x, y, count, name)
end

--- Добавляет отряд существ на поле боя. Этот отряд сохранится в армии героя после боя.
---@param side CombatSide сторона боя
---@param creature CreatureID id существа
---@param count integer число существ
---@param x integer координата X(по умолчанию -1 - случайная координата)
---@param y integer координата Y(по умолчанию -1 - случайная координата)
---@param is_summoned boolean 1 - существо будет иметь статус "призван", nil - нет(по умолчанию)
---@param name string скриптовое имя отряда
function AddCreature(side, creature, count, x, y, is_summoned, name)
end

--- Гибель существа атакующей стороны
---@param creature string скриптовое имя погибшего отряда существ
function AttackerCreatureDeath(creature)
end

--- Ход существа атакующей стороны
---@param creature string скриптовое имя отряда существ, совершающего ход
function AttackerCreatureMove(creature)
end

--- Ход героя атакующей стороны
---@param hero string скриптовое имя героя, совершающего ход
function AttackerHeroMove(hero)
end

--- Разрушение осадной машины атакующей стороны
---@param machine string скриптовое имя машины
function AttackerWarMachineDeath(machine)
end

--- Ход осадной машины атакующей стороны
---@param machine string скриптовое имя машины
function AttackerWarMachineMove(machine)
end
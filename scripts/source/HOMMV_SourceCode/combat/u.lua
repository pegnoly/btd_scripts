--- Колдует заклинание действующее на определенный объект на поля боя
---@param unit string скриптовое имя юнита
---@param spell integer id заклинания
---@param target string скриптовое имя цели
function UnitCastAimedSpell(unit, spell, target)
end

--- Колдует заклинание действующее на определенную область поля боя
---@param unit string скриптовое имя юнита
---@param spell id заклинания
---@param x integer координата X
---@param y integer координата Y
function UnitCastAreaSpell(unit, spell, x, y)    
end

--- Колдует ненаправленное заклинание
---@param unit string скриптовое имя юнита
---@param spell id заклинания
function UnitCastGlobalSpell(unit, spell)
end
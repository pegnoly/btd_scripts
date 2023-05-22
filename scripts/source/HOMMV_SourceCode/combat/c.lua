--- Устанавливает паузу в бою
---@param is_paused boolean установить/снять паузу
function combatSetPause(is_paused)
end

--- Отыграть эмоцию армией заданной стороны
---@param side CombatSide сторона боя
---@param emotion boolean 1 - эмоция победы, nil - поражения
function combatPlayEmotion(side, emotion)
end

--- Выдает юнита готового к действию или nil если такого нет
---@return string|nil unit скриптовое имя юнита/nil
function combatReadyPerson()
end

--- Возвращает, началось ли сражение
---@return boolean is_started битва началась/нет
function combatStarted()
end

--- Отдает юниту команду обороны
---@param unit string скриптовое имя юнита
---@param use_game_logic_limit boolean следовать игровым ограничениям(1)/нет(nil - по умолчанию)
function commandDefend(unit, use_game_logic_limit)
end

--- Дает существу команду применить специальное умение
---@param creature string скриптовое имя существа
---@param ability integer id умения
---@param x integer координата X точки применения(-1 по умолчанию - положение существа)
---@param y integer координата Y точки применения(-1 по умолчанию - положение существа)
---@param use_game_logic_limit boolean следовать игровым ограничениям(1)/нет(nil - по умолчанию)
function commandDoSpecial(creature, ability, x, y, use_game_logic_limit)
end

--- Дать существу команду идти в другое место
---@param creature string скриптовое имя существа
---@param x integer координата X точки назначения
---@param y integer координата Y точки назначения
---@param use_game_logic_limit boolean следовать игровым ограничениям(1)/нет(nil - по умолчанию)
function commandMove(creature, x, y, use_game_logic_limit)
end

--- Дать существу команду атаковать ближней атакой
---@param creature string скриптовое имя существа
---@param target string скриптовое имя цели
---@param use_game_logic_limit boolean следовать игровым ограничениям(1)/нет(nil - по умолчанию)
function commandMoveAttack(creature, target, use_game_logic_limit)
end

--- Дать существу команду атаковать дальней атакой
---@param creature string скриптовое имя существа
---@param target string скриптовое имя цели
---@param use_game_logic_limit boolean следовать игровым ограничениям(1)/нет(nil - по умолчанию)
function commandShot(creature, target, use_game_logic_limit)
end
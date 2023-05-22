--- Заставляет героя взаимодействовать с указанным объектом незамедлительно, даже, если герой находится в удалении от объекта
---@param hero string скриптовое имя героя
---@param object string скриптовое имя объекта
function MakeHeroInteractWithObject(hero, object)
end

--- Разрешает герою поднимать  undead-существ после боя в соответствии с  указанным уровнем Некромантии
---@param hero string скриптовое имя героя
---@param mastery MasteryLevel уровень навыка Некромантии
function MakeHeroNecromancer(hero, mastery)
end

--- Делает так, чтобы после поражения, герой всегда помещался в таверну игрока и ожидал в ней дальнейшего найма
---@param hero string скриптовое имя героя
---@param is_enable boolean возвращается в таверну/нет
---@param stay_until_hired integer 1 - герой находится в таверне, пока не будет нанят заново, 0(по умолчанию) - не находится
function MakeHeroReturnToTavernAfterDeath(hero, is_enable, stay_until_hired)
end

--- Позволяет перемещать и вращать город
---@param town string скриптовое имя города
function MakeTownMovable(town)
end

--- Помечает выключенный интерактивный объект как использованный данным героем
---@param object string скриптовое имя объекта
---@param hero string скриптовое имя героя
function MarkObjectAsVisited(object, hero)
end

--- Выводит на экран сообщение
---@param path string путь к тексту сообщения
---@param callback string имя функции, которая активируется при закрытии сообщения
function MessageBox(path, callback)
end

--- Перемещает камеру в заданную точку карты
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param zoom number параметр определяет насколько далеко будет расположена камера от заданной клетки
---@param pitch number угол наклона камеры (0 - камера смотрит вдоль горизонта, pi/2 — вертикально вниз)
---@param yaw number угол поворота камеры (0 - север)
---@param no_zoom boolean установить в 1, чтобы камера не меняла zoom (приближение) при движении
---@param no_rotate boolean установить в 1, чтобы камера не вращалась при движении
---@param no_move boolean перемещать камеру мгновенно или нет
function MoveCamera(x, y, floor, zoom, pitch, yaw, no_zoom, no_rotate, no_move)
end

--- Отдает герою приказ двигаться в определенную точку
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты(-1 по умолчанию, что означает уровень, на котором находится герой)
function MoveHero(hero, x, y, floor)
end

--- Заставляет героя немедленно двигаться в определенную точку
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты(-1 по умолчанию, что означает уровень, на котором находится герой)
function MoveHeroRealTime(hero, x, y, floor)
end

--- Возвращает остаток от деления
---@param x number|integer делимое
---@param y number|integer делитель
---@return number|integer mod остаток
function mod(x, y)
end


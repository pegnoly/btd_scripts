--- Проигрывает 2D-звук
---@param path string путь к файлу звука в ресурсах игры
function Play2DSound(path)
end

--- Проигрывает 3D-звук
---@param path string путь к файлу звука в ресурсах игры
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
function Play3DSound(path, x, y, floor)
end

--- Проигрывает анимацию на объекте карты
---@param object string скриптовое имя объекта
---@param anim string имя анимации
---@param type AnimationActionType тип проигрывания
function PlayObjectAnimation(object, anim, type)
end

--- Проигрывает заданный визуальный эффект (без звука) на объекте карты
---@param effect string путь к файлу эффекта
---@param object string скриптовое имя объекта
---@param name string скриптовое имя эффекта
---@param x number смещение по оси X от положения объекта(0 по умолчанию)
---@param y number смещение по оси Y от положения объекта(0 по умолчанию)
---@param z number смещение по оси Z от положения объекта(0 по умолчанию)
---@param rot number угол поворота эффекта(0 по умолчанию)
---@param floor MapLevel уровень карты(GROUND по умолчанию)
function PlayVisualEffect(effect, object, name, x, y, z, rot, floor)
end

--- Возвращает функцию, которая интерпретирует строку
---@param str string строка
function parse(str)
end

--- Выводит текстовое представление аргумента(-ов) в консоль
---@param ... any аргументы
function print(...)
end


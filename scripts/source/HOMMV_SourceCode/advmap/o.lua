--- Открывает туман войны в заданном круге
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param range number радиус открытия
---@param player PlayerID id игрока
function OpenCircleFog(x, y, floor, range, player)
end

--- Виртуально посещает заданное количество обелисков для данного игрока
---@param player PlayerID id игрока
---@param num integer число обелисков
function OpenPuzzleMap(player, num)
end

--- Открывает туман войны в заданном регионе
---@param player PlayerID id игрока
---@param region string скриптовое имя региона
function OpenRegionFog(player, region)
end

--- Отменяет указанные значения для данного индекса диалогов
---@param dialog number индекс диалога в ресурсах игры
---@param floor MapLevel уровень карты
---@param x number координата X
---@param y number координата Y
---@param z number координата Z
function OverrideAdvMapDialogPos(dialog, floor, x, y, z)
end

--- Позволяет задавать другое название и описание для большинства объектов на карте (но для некоторых объектов подобное невозможно)
---@param object string скриптовое имя объекта
---@param name string путь к файлу с именем 
---@param desc string путь к файлу с описанием
function OverrideObjectTooltipNameAndDescription(object, name, desc)
end


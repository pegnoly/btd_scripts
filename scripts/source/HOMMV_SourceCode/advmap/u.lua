--- Разблокирует интерфейс пользователя и работу AI
function UnblockGame()
end

--- Делает зарезервированного для определенного игрока героя снова доступным для остальных игроков
---@param hero string скриптовое имя героя
function UnreserveHero(hero)
end

--- Модернизирует (либо возводит) в указанном городе заданное городское строение. Если выбранное строение недоступно - генерируется ошибка
---@param town string скриптовое имя города
---@param building TownBuildingType id здания
function UpgradeTownBuilding(town, building)
end
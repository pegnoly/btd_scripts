--- Запрещает герою AI сбегать из боя
---@param hero_name string скриптовое имя героя, для которого ставится запрет
---@param is_denied integer 1 - запрещает сбегание, 0 - разрешает
---@param enemy_name string скриптовое имя героя, для боя с которым устанавливается запрет
function DenyAIHeroFlee(hero_name, is_denied, enemy_name)
end

--- Запрещает всем героям AI сбегать из боя
---@param player PlayerID id игрока, героям которого устанавливается запрет
---@param is_denied integer 1 - запрещает сбегание, 0 - разрешает
---@param enemy_name string скриптовое имя героя, для боя с которым устанавливается запрет
function DenyAIHeroesFlee(player, is_denied, enemy_name)
end

--- Предусматривает запрещение или разрешение изъятия существ в гарнизоне
---@param name string скриптовое имя гарнизона
---@param is_denied integer 1 - разрешено, 0 - запрещено
function DenyGarrisonCreaturesTakeAway(name, is_denied)
end

--- Ставит на карту героя, находящегося в резерве у игрока
---@param name string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param is_unique number значение 1 выключает общие запреты передвижения камеры, значение 0 - включает передвижение камеры обратно
function DeployReserveHero(name, x, y, floor, is_unique)
end

--- Демонтирует возведенное строение в городе до указанного уровня и может устанавливать этот уровень в качестве предельного для строения
---@param town string скриптовое имя города
---@param building TownBuildingType id строения
---@param level integer уровень
---@param can_rebuild integer 1(по умолчанию) - можно восстановить до предыдущего уровня, 0 - новый уровень является предельным
function DestroyTownBuildingToLevel(town, building, level, can_rebuild)
end

--- Выключает автоматическое появление городского экрана, когда герой входит в город
---@param town string скриптовое имя города
---@param id_disabled boolean 1 - экран не будет вызван
function DisableAutoEnterTown(town, id_disabled)
end

--- Выключает передвижение камеры при передвижении героев
---@param for_owner integer 1 выключает движение камеры для героев игрока, 0 включает
---@param for_ally integer 1 выключает движение камеры для героев союзника, 0 включает
---@param for_enemy integer 1 выключает движение камеры для героев врага, 0 включает
function DisableCameraFollowHeroes(for_owner, for_ally, for_enemy)
end

--- Позволяет запрещать передачу хода игроку AI, если у него нет городов или активных героев
---@param player PlayerID id игрока
---@param is_enabled nil nil - разрешает/1 - запрещает
function DoNotGiveTurnToPlayerAIIfNoTownsAndActiveHeroes(player, is_enabled)
end

--- Функция загружает (и выполняет) файл скрипта карты, лежащий по указанному пути
---@param file string путь к файлу скрипта
function doFile(file)
end
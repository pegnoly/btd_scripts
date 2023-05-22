--- Генерирует существ на карте
---@param creature CreatureID тип существ
---@param groups_min integer минимальное число отрядов
---@param groups_max integer максимальное число отрядов
---@param count_min integer минимальное число существ в отряде
---@param count_max integer максимальное число существ в отряде
function GenerateMonsters(creature, groups_min, groups_max, count_min, count_max)
end

--- Генерирует существ на карте
---@param creature CreatureID тип существ
---@param groups_min integer минимальное число отрядов
---@param groups_max integer максимальное число отрядов
---@param count_min integer минимальное число существ в отряде
---@param count_max integer максимальное число существ в отряде
function GenerateMobs(creature, groups_min, groups_max, count_min, count_max)
end

--- Позволяет выяснить - сколько артефактов указанного сета герой имеет в наличии (их общее количество, или сколько из них он в настоящее время использует)
---@param hero string скриптовое имя героя
---@param set ArtifactSetType id сета
---@param only_combined integer 1 - только надетые части сета, 0 - учитываются лежащие в инвентаре
function GetArtifactSetItemsCount(hero, set, only_combined)
end

--- Позволяет выяснить текущий тип недели в игре
---@return WeekType week тип недели
function GetCurrentMoonWeek()
end

--- Определяет текущего игрока
---@return PlayerID|integer player id игрока(-1 при одновременных ходах)
function GetCurrentPlayer()
end

--- Возвращает текущее игровое время (день, неделю, месяц или день недели)
---@param type DateType тип даты
---@return integer date игровая дата
function GetDate(type)
end

--- Определяет количество существ заданного вида, находящихся под командованием героя
---@param hero string скриптовое имя героя
---@param creature CreatureID id существа
---@return integer count число существ
function GetHeroCreatures(hero, creature)
end

--- Определяет уровень героя
---@param hero string скриптовое имя героя
---@return integer level уровень
function GetHeroLevel(hero)
end

--- Возвращает массив типов существ в армии героя (независимо от того, какие слоты они занимают)
---@param hero string скриптовое имя героя
---@return CreatureID[] creatures массив id существ
function GetHeroCreaturesTypes(hero)
end

--- Возвращает уровень владения героя навыком
---@param hero string скриптовое имя героя
---@param skill HeroSkillType id навыка
---@return MasteryLevel mastery уровень навыка
function GetHeroSkillMastery(hero, skill)
end

--- Определяет параметры героя
---@param hero string скриптовое имя героя
---@param stat HeroStatType id стата
---@return integer amount число стата
function GetHeroStat(hero, stat)
end

--- Определяет город, в котором находится герой
---@param hero string скриптовое имя героя
---@return string|nil town скриптовое имя города/nil, если герой не в городе
function GetHeroTown(hero)
end

--- Возвращает максимальный уровень карты
---@return MapLevel level уровень
function GetMaxFloor()
end

--- Возвращает тип и количество существ в слоте объекта
---@param object string скриптовое имя объекта
---@param slot integer номер слота
---@return CreatureID creature существо
---@return integer count численность
function GetObjectArmySlotCreature(object, slot)
end

--- Определяет количество существ заданного вида, находящихся в армии объекта
---@param object string скриптовое имя объекта
---@param creature CreatureID id существа
---@return integer count integer число существ
function GetObjectCreatures(object, creature)
end

--- Возвращает массив типов существ в армии объекта (независимо от того, какие слоты они занимают)
---@param object string скриптовое имя объекта
---@return CreatureID[] creatures массив id существ
function GetObjectCreaturesTypes(object)
end

--- Возвращает стэки существ, доступных для найма в данном городе для указанного уровня. Функция возвратит -1, если соответствующего жилища существ  в указанном городе не имеется
---@param town string скриптовое имя города
---@param tier integer уровень стэков существ в жилищах 
---@return integer count число существ указанного тира(-1, если строения нет)
function GetObjectDwellingCreatures(town, tier)
end

--- Возвращает массив объектов, мимо которых  проследует герой от текущего местоположения до заданной точки выбранного уровня
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата X
---@param floor MapLevel уровень карты
---@return table objects таблица скриптовых имен объектов
function GetObjectsFromPath(hero, x, y, floor)
end

--- Определяет прогресс выполнения задания
---@param name string скриптовое имя задания
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
---@return integer progress прогресс задания
function GetObjectiveProgress(name, player)
end

--- Определяет состояние задания
---@param name string скриптовое имя задания
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
---@return ObjectiveStateType state состояние задания
function GetObjectiveState(name, player)
end

--- Определяет принадлежность объекта
---@param object string скриптовое имя объекта
---@return PlayerID player id игрока
function GetObjectOwner(object)
end

--- Определяет, какие объекты находятся в заданной области (регионе)
---@param region string скриптовое имя региона
---@param type string тип объектов
---@return string[] objects список скриптовых имен объектов
function GetObjectsInRegion(region, type)
end

--- Определяет положение объекта на карте
---@param object string скриптовое имя объекта
---@return number x x-координата
---@return number y y-координата
---@return MapLevel floor уровень карты
function GetObjectPosition(object)
end

--- Возвращает имена героев принадлежащих игроку
---@param player PlayerID id игрока
---@return string[] heroes список скриптовых имен героев
function GetPlayerHeroes(player)
end

--- Возвращает количество тёмной энергии у игрока (для расы некромантов)
---@param player PlayerID id игрока
---@return integer count число энергии
function GetPlayerNecroEnergy(player)
end

--- Возвращает расу игрока по его идентификатору
---@param player PlayerID id игрока
---@return TownType race id расы
function GetPlayerRace(player)
end

--- Выясняет количество ресурсов у игрока
---@param player PlayerID id игрока
---@param type ResourceType тип ресурса
---@return integer amount число ресурса
function GetPlayerResource(player, type)
end

--- Позволяет выяснять бонус, выбранный  игроком на старте карты в кампании
---@param player PlayerID id игрока
---@return integer bonus выбранный бонус
function GetPlayerSelectedCampaignBonusIndex(player)
end

--- Выясняет текущее состояние игрока
---@param player PlayerID id игрока
---@return PlayerGameState state состояние игрока
function GetPlayerState(player)
end

--- Возвращает номер команды игрока
---@param player PlayerID id игрока
---@return PlayerTeam team номер команды
function GetPlayerTeam(player)
end

--- Определяет длину указанного звукового файла и возвращает число секунд длительности его звучания
---@param path string путь к файлу в ресурсах игры
---@return integer sleeps длительность файла
function GetSoundTimeInSleeps(path)
end

--- Определяет текущее состояния стенда на карте
---@param name string скриптовое имя стенда
---@return integer state текущее состояние
function GetStandState(name)
end

--- Определяет количество возможных состояний стенда на карте
---@param name string скриптовое имя стенда
---@return integer count число состояний
function GetStandStatesCount(name)
end

--- Возвращает размер текущей карты в тайлах
---@return integer size размер карты
function GetTerrainSize()
end

--- Определяет уровень постройки здания в городе
---@param town string скриптовое имя города
---@param building TownBuildingType id здания
---@return integer level уровень здания
function GetTownBuildingLevel(town, building)
end

--- Определяет ограничение на уровень постройки здания в городе
---@param town string скриптовое имя города
---@param building TownBuildingType id здания
---@return integer level уровень ограничения
function GetTownBuildingLimitLevel(town, building)
end

--- Определяет максимальный уровень постройки здания в городе
---@param town string скриптовое имя города
---@param building TownBuildingType id здания
---@return integer level максимальный уровень здания
function GetTownBuildingMaxLevel(town, building)
end

--- Возвращает героя, находящегося в гарнизоне города
---@param town string скриптовое имя города
---@return string|nil hero скриптовое имя героя 
function GetTownHero(town)
end

--- Возвращает расу города
---@param town string скриптовое имя города
---@return TownType race раса города
function GetTownRace(town)
end

--- Выдает герою артефакт с возможностью привязки (т.е. сделать артефакт непередаваемым)
---@param hero string скриптовое имя героя
---@param artifact ArtifactID id артефакта
---@param bind_to_hero boolean привязывать к герою/нет
function GiveArtefact(hero, artifact, bind_to_hero)
end

--- Дает игроку ключ определенного цвета
---@param player PlayerID id игрока
---@param key BorderguardKeyColor цвет ключа
function GiveBorderguardKey(player, key)
end

--- Даёт герою бонус на следующую битву
---@param hero string скриптовое имя героя
---@param bonus HeroBattleBonusType тип бонуса
---@param amount integer численность бонуса
function GiveHeroBattleBonus(hero, bonus, amount)
end

--- Дает герою заданный базовый навык 
---@param hero string скриптовое имя героя
---@param skill HeroSkillType id скилла
function GiveHeroSkill(hero, skill)
end

--- Дает герою машину заданного типа
---@param hero string скриптовое имя героя
---@param type WarMachineType тип машины
function GiveHeroWarMachine(hero, type)
end

--- Получает количество MovePoints (в которых измеряется стоимость пути по карте)
---@param hero string скриптовое имя героя
---@return integer mp число мувпоинтов
function GetHeroMovePoints(hero)
end

--- Получает все объекты заданного типа
---@param type string тип объектов
---@return string[] objects список скриптовых имен объектов
function GetObjectNamesByType(type)
end

--- Определяет уровень сложности игры
---@return DifficultyLevel level уровень сложности
function GetDifficulty()
end

--- Возвращает значение общеигровой переменной
---@param name string имя переменной
---@return string val значение переменной
function GetGameVar(name)
end

--- Возвращает путь к карте
function GetMapDataPath()
end

--- Возвращает индекс последнего произошедшего боя
---@return integer index индекс боя
function GetLastSavedCombatIndex()
end

--- Получает информацию о существах, сражавшихся в бою
---@param index integer индекс боя
---@param is_winner integer 1 - для победившей стороны, 0 - для проигравшей
---@param stack integer номер стека
---@return CreatureID creature id существа из стека
---@return integer stack_count общее число существ, которые сражались в заданном стеке
---@return integer dead_count число существ, которые умерли в этом стеке
function GetSavedCombatArmyCreatureInfo(index, is_winner, stack)
end

--- Получает информацию о стеках существ, сражавшихся в бою
---@param index integer индекс боя
---@param is_winner integer 1 - для победившей стороны, 0 - для проигравшей
---@return integer stacks число стеков, которые сражались в бою на заданной стороне
function GetSavedCombatArmyCreaturesCount(index, is_winner)
end

--- Получает информацию о героях, сражавшихся в бою
---@param index integer индекс боя
---@param is_winner integer 1 - для победившей стороны, 0 - для проигравшей
---@return string hero скриптовое имя героя, который сражался на заданной стороне/nil, если его не было
function GetSavedCombatArmyHero(index, is_winner)
end

--- Получает информацию об игроках, сражавшихся в бою
---@param index integer индекс боя
---@param is_winner integer 1 - для победившей стороны, 0 - для проигравшей
---@return PlayerID player id игрока, который сражался на заданной стороне/nil 
function GetSavedCombatArmyPlayer(index, is_winner)
end

--- Получает информацию о результате боя
---@param index integer индекс боя
---@return SavedCombatResultType result результат боя
function GetSavedCombatResult(index)
end
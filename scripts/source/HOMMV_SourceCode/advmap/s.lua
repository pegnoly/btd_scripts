--- Устанавливает цель для заданного AI героя
---@param object string скриптовое имя цели
---@param hero string скриптовое имя ии-героя
---@param priority integer уровень приоритета цели(от -1 до 2)
function SetAIHeroAttractor(object, hero, priority)
end

--- Устанавливает, что для героя ии не работают изменения возможности сбегания из боя
---@param hero string скриптовое имя ии-героя
function SetAIHeroFleeControl(hero)
end

--- Устанавливает приоритет объекта для всех героев AI игрока
---@param object object string скриптовое имя цели
---@param player PlayerID id ии-игрока
---@param priority integer уровень приоритета цели(от -1 до 2)
function SetAIPlayerAttractor(object, player, priority)
end

--- Меняет освещение на заданном уровне карты
---@param floor MapLevel уровень карты
---@param name string имя источника света в ресурсах карты
---@param fade boolean менять мгновенно(nil - по умолчанию), с задержкой(1)
---@param time integer время, за которое меняется освещение(1 по умолчанию)
function SetAmbientLight(floor, name, fade, time)
end

--- Меняет освещение на всех боевых аренах карты
---@param name string путь к файлу источника света
function SetCombatLight(name)
end

--- Позволяет определить, что отобразится под курсором на  выключенном интерактивном объекте
---@param object string скриптовое имя объекта
---@param mode ObjectInteractionCursorType тип курсора
function SetDisabledObjectMode(object, mode)
end

--- Назначает боевой скрипт герою
---@param hero string скриптовое имя героя
---@param path string путь к файлу скрипта
function SetHeroCombatScript(hero, path)
end

--- Задает, можно ли отобрать у героя артефакты, победив его
---@param hero string скриптовое имя героя
---@param is_lootable boolean можно отобрать(1)/нельзя(nil)
function SetHeroLootable(hero, is_lootable)
end

--- Предоставляет возможность  изменения биографии героя в ходе игры
---@param hero string скриптовое имя героя
---@param new_bio string путь к файлу биографии
function SetHeroBiography(hero, new_bio)
end

--- Устанавливает определенное управление «распределением ролей» между героями AI
---@param hero string скриптовое имя героя
---@param role HeroRoleMode роль
function SetHeroRoleMode(hero, role)
end

--- Позволяет устанавливать коэффициент для опыта, получаемого героями
---@param coef number коэффициент опыта
function SetHeroesExpCoef(coef)
end

--- Позволяет задавать храбрость существ и их настроение по отношению к указанному игроку
---@param monster string скриптовое имя отряда существ
---@param player PlayerID id игрока
---@param mood MonsterMoodType настроение существ
---@param courage MonsterCourageType храбрость существ
function SetMonsterCourageAndMood(monster, player, mood, courage)
end

--- Позволяет менять имена стэка существ и армии существ
---@param monster string скриптовое имя отряда существ
---@param name_filter MonsterNameFilter фильтр имени
---@param name_file string путь к файлу с именем
function SetMonsterNames(monster, name_filter, name_file)
end

--- Позволяет настраивать метку выбора, расположенную под монстром
---@param monster string скриптовое имя отряда существ
---@param selection integer тип метки(от -1 до 2)
function SetMonsterSelectionType(monster, selection)
end

--- Устанавливает стэки существ и их количество, доступное для найма в данном городе. Функция не позволяет изменить тип нанимаемых существ, с ее помощью можно управлять только их количеством
---@param town string скриптовое имя города
---@param tier integer уровень существ
---@param count integer число существ
function SetObjectDwellingCreatures(town, tier, count)
end

--- Позволяет включать и выключать взаимодействие интерактивного объекта с героем стандартным образом
---@param object string скриптовое имя объекта
---@param is_enabled boolean 1 - включить, nil - выключить
function SetObjectEnabled(object, is_enabled)
end

--- Цепляет к объекту карты точечный источник света
---@param object string скриптовое имя объекта
---@param light string имя источника света в ресурсах игры
function SetObjectFlashlight(object, light)
end

--- Задает прогресс выполнения задания
---@param name string скриптовое имя задания
---@param progress integer новый прогресс
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
function SetObjectiveProgress(name, progress, player)
end

--- Меняет принадлежность находящихся на карте объектов
---@param object string скриптовое имя объекта
---@param player PlayerID id игрока
function SetObjectOwner(object, player)
end

--- Перемещает объект
---@param obejct string скриптовое имя объекта
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты(по умолчанию равен -1, что означает тот же уровень)
---@param fx integer Только для героев! Задаёт номер эффекта телепортации (-1 = по-умолчанию, 0 - выключен, 1 - warp, 2 - teleport, 3 - dimension door, 4 - town portal
function SetObjectPosition(obejct, x, y, floor, fx)
end

--- Вращает заданный объект на карте
---@param object string скриптовое имя объекта
---@param rot number угол поворота
function SetObjectRotation(object, rot)
end

--- Меняет состояние задания
---@param name string скриптовое имя задания
---@param state ObjectiveStateType новое состояние
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
function SetObjectiveState(name, state, player)
end

--- Отображает / скрывает задание в интерфейсе конкретного игрока
---@param name string скриптовое имя задания
---@param is_visible boolean отображать задание(1)/нет(nil)
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
function SetObjectiveVisible(name, is_visible, player)
end

--- Устанавливает количество героев, заблокированных для найма определенный игроком заданным количеством
---@param player PlayerID id игрока
---@param count integer количество героев, заблокированных для найма
function SetPlayerHeroesCountNotForHire(player, count)
end

--- Устанавливает количество ресурсов у игрока
---@param player PlayerID id игрока
---@param type ResourceType тип ресурса
---@param amount integer число ресурса
function SetPlayerResource(player, type, amount)
end

--- Устанавливает стартовое количество ресурсов у игрока
---@param player PlayerID id игрока
---@param wood integer число дерева
---@param ore integer число руды
---@param mercury integer число ртути
---@param crystal integer число кристаллов
---@param sulfur integer число серы
---@param gem integer число самоцветов
---@param gold integer число золота
function SetPlayerStartResources(player, wood, ore, mercury, crystal, sulfur, gem, gold)
end

--- Устанавливает команду  игрока
---@param player PlayerID id игрока
---@param team PlayerTeam id команды
function SetPlayerTeam(player, team)
end

--- Автоматически включает \ выключает объекты или блокирует \ разблокирует  регион, когда герои входят в, либо покидают данный регион
---@param region string скриптовое имя региона
---@param auto_mode RegionAutoActionMode тип действия
---@param town TownType проверять только героев заданной расы(по умолчанию -1, не проверять на расу)
---@param player PlayerID проверять только героев заданного игрока(по умолчанию -1, не проверять на игрока)
---@param hero string проверять только указанного героя(по умолчанию "" - не проверять на героя)
---@param object string выключать только заданный объект(по умолчанию "" - все объекты)
---@param type RegionAutoActionEnableVariant тип действия функции на регион
function SetRegionAutoObjectEnable(region, auto_mode, town, player, hero, object, type)
end

--- Устанавливает/снимает блокировку прохождения региона героями
---@param region string скриптовое имя региона
---@param is_blocked boolean 1 - блокировать/nil - нет
---@param player PlayerID id игрока(по умолчанию -1, для всех игроков)
function SetRegionBlocked(region, is_blocked, player)
end

--- Меняет состояние стенда на карте
---@param stand string скриптовое имя стенда
---@param state integer новое состояние
function SetStandState(stand, state)
end

--- Задает ограничение на уровень постройки здания в городе
---@param town string скриптовое имя города
---@param building TownBuildingType id здания
---@param limit integer лимит постройки
function SetTownBuildingLimitLevel(town, building, limit)
end

--- Включяет/выключает снятие тумана войны героями игрока
---@param on_land integer будет ли герой игрока, перемещаясь по суше, снимать туман (1/ 0)
---@param on_sea integer будет ли герой игрока, перемещаясь по воде, снимать туман (1/ 0)
---@param player PlayerID id игрока(PLAYER_1 по умолчанию)
function SetWarfogBehaviour(on_land, on_sea, player)
end

--- Отображает отлетающее от объекта сообщение
---@param message string путь к файлу сообщения
---@param object string скриптовое имя объекта
---@param player PlayerID id игрока, для которого показывается сообщение(по умолчанию -1 - для всех игроков)
---@param time number время, на которое появляется сообщение
function ShowFlyingSign(message, object, player, time)
end

--- Инициирует осаду города
---@param hero string скриптовое имя героя
---@param town string скриптовое имя города
---@param arena string путь к файлу арены(по умолчанию отсутствует, что означает, что бой будет на стандартной городской)
function SiegeTown(hero, town, arena)
end

--- Затапливает корабль, и герой исчезает, если он находится в нем
---@param hero string скриптовое имя героя
function SinkHero(hero)
end

--- Стартует сцену мини-диалога
---@param index integer индекс диалога в ресурсах карты
---@param callback string имя функции, которая будет запущена при закрытии диалога
function StartAdvMapDialog(index, callback)
end

--- Запускает сражение с заданными параметрами
---@param hero string скриптовое имя героя
---@param enemy string|nil скриптовое имя героя противника(nil - бой против нейтралов)
---@param stack_count integer число стеков
---@param ... CreatureID|integer пары id существа-численность стека, число пар равно stack_count
---@param script? string|nil путь к файлу боевого скрипта, который будет управлять этим боем(nil по умолчанию - нет скрипта)
---@param callback? string|nil имя функции, которая будет запущена по окончанию боя(nil по умолчанию - нет функции)
---@param arena? string|nil путь к файлу арены, на которой будет проходить бой(nil по умолчанию - стандартная арена)
---@param is_quick_combat? nil 1 - сражение будет запущено в режиме быстрого боя, если этот режим включен в опциях игры и у героя не отключена возможность быстрого боя (по умолчанию — nil, то есть запускается обычное сражение)
function StartCombat(hero, enemy, stack_count, ..., script, callback, arena, is_quick_combat)
end

--- Запускает ролик
---@param name string путь к файлу ролика
---@param callback? string имя функции, которая будет запущена после закрытия ролика
---@param save_name? string имя сохранения, которое будет сделано перед роликом
function StartCutScene(name, callback, save_name)
end

--- Запускает диалоговую сцену
---@param name string путь к файлу сцены
---@param callback? string имя функции, которая будет запущена после закрытия сцены
---@param save_name? string имя сохранения, которое будет сделано перед сценой
function StartDialogScene(name, callback, save_name)
end

--- Останавливает проигрывание зацикленного звука
---@param name string скриптовое имя источника звука
function StopPlaySound(name)
end

--- Останавливает проигрывание визуального эффекта на карте
---@param name string скриптовое имя эффекта
function StopVisualEffects(name)
end

--- Сохраняет игру в указанный файл
---@param name string имя файла сохранения
function Save(name)
end

--- Устанавливает значение глобальной переменной
---@param name string имя переменной
---@param value any значение переменной
function SetGameVar(name, value)
end

--- Останавливает работу текущего потока исполнения на указанное время. Время задается в игровых сегментах
---@param num integer длительность остановки в сегментах
function sleep(num)
end

--- Извлекает квадратный корень из числа
---@param n number число
---@return number res квадратный корень
function sqrt(n)
end

--- Запускает функцию в новом потоке исполнения
---@param func function функция
function startThread(func)
end
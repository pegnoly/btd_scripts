--- Вычисляет средний уровень существ, стоящих на карте
---@param floor MapLevel уровень карты(-1 для рассчета на обоих уровнях)
---@return integer tier уровень существ
function CalcAverageMonstersTier(floor)
    local tier = -1
    return tier
end

--- Вычисляет средний уровень существ, стоящих на карте
---@param floor MapLevel уровень карты(-1 для рассчета на обоих уровнях)
---@return integer уровень существ
function CalcAverageTier(floor)
end

--- Вычисляет стоимость передвижения героя в заданную точку
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@return integer cost стоимость передвижения
function CalcHeroMoveCost(hero, x, y, floor)
    local cost = -1
    return cost
end

--- Определяет, возможно ли передвижение героя в заданную точку
---@param hero string скриптовое имя героя
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@return boolean can_move передвижение возможно/нет
function CanMoveHero(hero, x, y, floor)
    local can_move = nil
    return can_move
end

--- Меняет параметры героя
---@param hero string скриптовое имя героя
---@param stat HeroStatType id стата
---@param delta number изменение стата
function ChangeHeroStat(hero, stat, delta)
end

--- Изменяет количество ресурсов указанного вида  для игрока, обладающего указанным героем. При этом от данного героя появляется «отлетающее» сообщение, указывая на изменение ресурса
---@param res_type ResourceType id ресурса
---@param amount integer число ресурса
---@param hero string скриптовое имя героя
function ChangeResource(res_type, amount, hero)
end

--- Позволяет управлять особыми умениями указанного героя, посредством триггера
---@param hero string скриптовое имя героя
---@param ability_id CustomAbilityId id умения
---@param ability_mode CustomAbilityMode состояние умения
function ControlHeroCustomAbility(hero, ability_id, ability_mode)
end

--- Создает артефакт на карте
---@param art_name string скриптовое имя артефакта
---@param art_id integer id артефакта
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
function CreateArtifact(art_name, art_id, x, y, floor)
end

--- Создает пустой караван на карте
---@param name string скриптовое имя каравана
---@param player PlayerID id игрока, которому принадлежит караван
---@param floor MapLevel уровень карты, на котором создается караван
---@param x number координата X, на которой создается караван
---@param y number координата Y, на которой создается караван
---@param dest_floor MapLevel уровень карты, на который должен быть отправлен караван
---@param dest_x number координата X, на которую должен быть отправлен караван
---@param dest_y number координата Y, на которую должен быть отправлен караван
function CreateCaravan(name, player, floor, x, y, dest_floor, dest_x, dest_y)
end

--- Создает жилище на карте
---@param name string скриптовое имя жилища
---@param town TownType id расы жилища
---@param tier integer уровень существ
---@param owner PlayerID id игрока, которому принадлежит жилище
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param rot integer угол поворота(кратен 90)
function CreateDwelling(name, town, tier, owner, x, y, floor, rot)
end

--- Создает монстра на карте
---@param name string скриптовое имя монстра
---@param id integer id существа
---@param count integer число существ
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param mood MonsterMoodType настроение существ
---@param courage MonsterCourageType храбрость существ
---@param rot number угол поворота
---@param is_diff_undepended nil число зависит от сложности(nil)/нет(1)
function CreateMonster(name, id, count, x, y, floor, mood, courage, rot, is_diff_undepended)
end

--- Создает монстра на карте
---@param name string скриптовое имя монстра
---@param id integer id существа
---@param count integer число существ
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param mood MonsterMoodType настроение существ
---@param courage MonsterCourageType храбрость существ
---@param rot number угол поворота
---@param is_diff_undepended nil число зависит от сложности(nil)/нет(1)
function CreateMob(name, id, count, x, y, floor, mood, courage, rot, is_diff_undepended)
end

--- Добавляет статический объект, упомянутый в файле данных, в точке с заданными координатами
---@param name string скриптовое имя объекта
---@param file string путь к файлу объекта
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
function CreateStatic(name, file, x, y, floor)
end

--- Создает сокровище соответствующего скриптового имени в указанной позиции с заданным поворотом
---@param name string скриптовое имя сокровища
---@param type TreasureKind тип сокровища
---@param amount integer количество ресурса (если это золото, то число умножается на 100)
---@param x number координата X
---@param y number координата Y
---@param floor MapLevel уровень карты
---@param rot number угол поворота
function CreateTreasure(name, type, amount, x, y, floor, rot)
end

--- Возвращает ближайшее верхнее целое значение для n (пример: ceil(2.25) вернёт 3, ceil(-7.1) вернёт -8)
---@param n number число
---@return integer res ближайшее целое число
function ceil(n)
end

--- Очищает от текста предназначенный для вывода tutorial-сообщений элемент
function clearMessage()
end

--- Выполнить консольную команду
---@param cmd string команда
function consoleCmd(cmd)
end


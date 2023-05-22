--- Отнимает указанное количество опыта у героя, случайным образом удаляет навыки
---@param hero string скриптовое имя героя
---@param exp integer число опыта
function TakeAwayHeroExp(hero, exp)
end

--- Открывает для выбранных игроков диалог с несколькими вариантами ответа (от 1 до 5). Функция не выдаёт сообщений об ошибке т.к. если параметры не верны, то используются значения по-умолчанию
---@param player PlayerFilter фильтр игрока, для которого выводится диалог
---@param icon string путь к файлу иконки диалога
---@param icon_tooltip string путь к файлу текста при клике на иконку
---@param text string путь к основному тексту диалога
---@param add_text string путь к дополнительному тексту диалога
---@param callback string имя функции, через первый параметр которой сообщается ответ игрока (число: 0 - отмена, -1 - закрыт игрой, 1.. - номер выбранного игроком ответа)
---@param mode integer тип режима: 0 - с кнопкой ОК, 1 - ОК/Закрыть
---@param title string путь к тексту заголовка окна
---@param select string путь к тексту заголовка перед опциями выбора
---@param default_option integer номер ответа, подсвеченного по-умолчанию (число: 0 - нет, 1.. - номер ответа)
---@param ... string пути к текстам ответов
function TalkBoxForPlayers(player, icon, icon_tooltip, text, add_text, callback, mode, title, select, default_option, ...)
end

--- Выдает герою заданное заклинание
---@param hero string скриптовое имя героя
---@param spell integer id спелла
function TeachHeroSpell(hero, spell)
end

--- Позволяет устанавливать и снимать функции-обработчики событий, происходящих в мире
---@param type TriggerType тип триггера
---@param ... any объект, на который устанавливается триггера(для некоторых типов)
---@param callback string имя функции, которая активируется триггером
function Trigger(type, ..., callback)
end

--- Меняет тип города на карте
---@param town string скриптовое имя города
---@param race TownType новая раса города
function TransformTown(town, race)
end

--- Находит в UIConsts.tutorialOptions.hints элемент-дескриптор по строковому идентификатору stringID
---@param id string строковый идентификатор
function TutorialActivateHint(id)
end

--- Находит в UIConsts.tutorialOptions.messages элемент по строковому идентификатору stringID
---@param id string строковый идентификатор
function TutorialMessageBox(id)
end

--- Находит в UIConsts.tutorialOptions.blinks элемент-дескриптор по строковому идентификатору stringID
---@param id string строковый идентификатор
---@param is_enabled boolean включить/выключить
function TutorialSetBlink(id, is_enabled)
end
--- Включает/выключает покупку AI героев в таверне города
---@param player PlayerID id игрока
---@param town string скриптовое имя города
---@param is_enabled nil 1 - разрешает, nil - запрещает
function EnableAIHeroHiring(player, town, is_enabled)
end

--- Включает/выключает контроль AI над заданным героем
---@param hero string скриптовое имя героя
---@param is_enabled nil 1 - включает, nil - выключает
function EnableHeroAI(hero, is_enabled)
end

--- Функция выдает в консоль сообщение об ошибке sMsg, эмулируя ошибку скрипта
---@param message string сообщение
function _ERRORMESSAGE(message)    
end

--- Позволяет установить перехватчик ошибки
---@param func function функция-перехватчик
function errorHook(func)
end

--- Выводит из игры, возвращая игрока на рабочий стол. При этом игра сохранена не будет
function ExitGame()
end
--- Выясняет, есть ли у героя артефакт
---@param hero string скриптовое имя героя
---@param artefact ArtifactID id артефакта
---@param is_equipped boolean надет артефакт/нет
---@return boolean has имеется артефакт/нет
function HasArtefact(hero, artefact, is_equipped)
end

--- Определяет, есть ли у игрока ключ определенного цвета
---@param player PlayerID id игрока
---@param key BorderguardKeyColor цвет ключа
---@return boolean has имеется ключ/нет
function HasBorderguardKey(player, key)
end

--- Проверяет наличие навыка у героя
---@param hero string скриптовое имя героя
---@param skill HeroSkillType id навыка
---@return boolean has имеется скилл/нет
function HasHeroSkill(hero, skill)
end

--- Определяет, есть ли у героя боевая машина заданного типа
---@param hero string скриптовое имя героя
---@param type WarMachineType тип машины
---@return boolean has имеется машина/нет
function HasHeroWarMachine(hero, type)
end


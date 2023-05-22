----------------------------
-- Скрипты загрузки дуэли --

-- инициализация очередей сообщений
MapLoadingEvent.AddListener("BTD_duel_message_queue_init_listener",
function()
    startThread(MessageQueue.Run, PLAYER_1)
    startThread(MessageQueue.Run, PLAYER_2)
end)

-- выдача стартовых ресурсов
MapLoadingEvent.AddListener("BTD_duel_start_res_listener",
function()
    for player = PLAYER_1, PLAYER_8 do
        SetPlayerStartResources(player, 0, 0, 0, 0, 0, 0, BTD_Duel.start_gold)
    end
end)

-- открытие тумана на стартовых зонах
MapLoadingEvent.AddListener("BTD_duel_fog_open_listener",
function()
    OpenRegionFog(PLAYER_1, "Player1GameZone")
    OpenRegionFog(PLAYER_2, "Player2GameZone")
end)

-- удаление стартовых армий героев(неактуально с черком?)
MapLoadingEvent.AddListener("BTD_duel_start_army_remove_listener",
function()
    for i, hero in GetObjectNamesByType("HERO") do
        startThread(
        function()
            for creature = 1, CREATURES_COUNT - 1 do
                RemoveHeroCreatures(%hero, creature, 9999)
            end
        end)
    end
end)

-- настройка городов
MapLoadingEvent.AddListener("BTD_duel_towns_init_listener",
function()
    for i, town in GetObjectNamesByType("TOWN") do
        startThread(
        function()
            local player = GetObjectOwner(%town)
            if GetCurrentPlayer() ~= -1 then
                while not IsPlayerCurrent(player) do
                sleep()
                end
            end
            for building = TOWN_BUILDING_TOWN_HALL, TOWN_BUILDING_SPECIAL_9 do
                pcall(SetTownBuildingLimitLevel, %town, building, 0)
            end
            sleep()
            local race = GetTownRace(%town)
            if race == TOWN_ACADEMY then
                UpgradeTownBuilding(%town, TOWN_BUILDING_ACADEMY_ARCANE_FORGE)
                UpgradeTownBuilding(%town, TOWN_BUILDING_ACADEMY_ARTIFACT_MERCHANT)
                UpgradeTownBuilding(%town, TOWN_BUILDING_ACADEMY_LIBRARY)
            elseif race == TOWN_DUNGEON then
                pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_DUNGEON_ALTAR_OF_ELEMENTS, 2)
                for i = 1, 2 do
                    UpgradeTownBuilding(%town, TOWN_BUILDING_DUNGEON_ALTAR_OF_ELEMENTS)
                end
                UpgradeTownBuilding(%town, TOWN_BUILDING_DUNGEON_TRADE_GUILD)
            elseif race == TOWN_PRESERVE then
                UpgradeTownBuilding(%town, TOWN_BUILDING_PRESERVE_AVENGERS_BROTHERHOOD)
            elseif race == TOWN_FORTRESS then
                pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_FORTRESS_RUNIC_SHRINE, 3)
                for i = 1, 3 do
                    UpgradeTownBuilding(%town, TOWN_BUILDING_FORTRESS_RUNIC_SHRINE)
                end
            elseif race == TOWN_STRONGHOLD then
                pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_STRONGHOLD_HALL_OF_TRIAL, 3)
                UpgradeTownBuilding(%town, TOWN_BUILDING_STRONGHOLD_TRAVELLERS_SHELTER)
                for i = 1, 3 do
                    UpgradeTownBuilding(%town, TOWN_BUILDING_STRONGHOLD_HALL_OF_TRIAL)
                end
            elseif race == TOWN_INFERNO then
                UpgradeTownBuilding(%town, TOWN_BUILDING_INFERNO_INFERNAL_LOOM)
            end
            --
            pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_MAGIC_GUILD, 5)
            for i = 1, 5 do
                UpgradeTownBuilding(%town, TOWN_BUILDING_MAGIC_GUILD)
            end
        end)
    end
end)

-- стартовое сообщение
MapLoadingEvent.AddListener('BTD_duel_start_message_listener',
function()
    for player = PLAYER_1, PLAYER_2 do
        startThread(MCCS_MessageBoxForPlayers, player, GetMapDataPath().."Messages/start.txt")
        startThread(SkipTurnMessage, player)
    end
end)
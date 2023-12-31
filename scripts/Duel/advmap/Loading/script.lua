----------------------------
-- Скрипты загрузки дуэли --

btd_duel_loading = {
    start_gold = 4000,
}

-- выдача стартовых ресурсов
MapLoadingEvent.AddListener("BTD_duel_start_res_listener",
function()
    for player = PLAYER_1, PLAYER_8 do
        SetPlayerStartResources(player, 0, 0, 0, 0, 0, 0, btd_duel_loading.start_gold)
    end
end)

-- открытие тумана на стартовых зонах
MapLoadingEvent.AddListener("BTD_duel_fog_open_listener",
function()
    OpenRegionFog(PLAYER_1, "Player1GameZone")
    OpenRegionFog(PLAYER_2, "Player2GameZone")
end)

AddHeroEvent.AddListener("BTD_duel_start_army_remove_listener",
function(hero)
    startThread(
    function()
        AddHeroCreatures(%hero, CREATURE_AIR_ELEMENTAL, 1)
        sleep()
        for creature = 1, 999 do
            if creature ~= CREATURE_AIR_ELEMENTAL then
                RemoveHeroCreatures(%hero, creature, 9999)
            end
        end
    end)
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
                UpgradeTownBuilding(%town, TOWN_BUILDING_ACADEMY_ARTIFACT_MERCHANT)
                UpgradeTownBuilding(%town, TOWN_BUILDING_ACADEMY_LIBRARY)
            elseif race == TOWN_DUNGEON then
                pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_DUNGEON_ALTAR_OF_ELEMENTS, 2)
                for i = 1, 2 do
                    UpgradeTownBuilding(%town, TOWN_BUILDING_DUNGEON_ALTAR_OF_ELEMENTS)
                end
                UpgradeTownBuilding(%town, TOWN_BUILDING_DUNGEON_TRADE_GUILD)
            elseif race == TOWN_PRESERVE then
                --UpgradeTownBuilding(%town, TOWN_BUILDING_PRESERVE_AVENGERS_BROTHERHOOD)
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
                UpgradeTownBuilding(%town, TOWN_BUILDING_INFERNO_ORDER_OF_FIRE)
            elseif race == TOWN_HEAVEN then
                UpgradeTownBuilding(%town, TOWN_BUILDING_HAVEN_TRAINING_GROUNDS)
                for i, dwell in {TOWN_BUILDING_DWELLING_2, TOWN_BUILDING_DWELLING_3, TOWN_BUILDING_DWELLING_5, TOWN_BUILDING_DWELLING_6} do
                    UpgradeTownBuilding(%town, dwell)
                    UpgradeTownBuilding(%town, dwell)
                end
                sleep()
                for i, creature in {CREATURE_ARCHER, CREATURE_FOOTMAN, CREATURE_PRIEST, CREATURE_CAVALIER} do
                    SetObjectDwellingCreatures(%town, creature, 0)
                end
            end
            --
            pcall(SetTownBuildingLimitLevel, %town, TOWN_BUILDING_MAGIC_GUILD, 5)
            for i = 1, 5 do
                UpgradeTownBuilding(%town, TOWN_BUILDING_MAGIC_GUILD)
            end
        end)
    end
end)

MapLoadingEvent.AddListener("btd_duel_loading_shrines_auto_visit",
function()
    consoleCmd("setvar ui_announcement_duration = 0")
    sleep()
    startThread(
    function ()
        for i, shrine in {'Shrine1_1','Shrine1_2','Shrine1_3','Shrine1_4','Shrine1_5','Shrine1_6'} do
            MakeHeroInteractWithObject("GhostFSLord1", shrine)
        end
    end)
    startThread(
    function ()
        for i, shrine in {'Shrine2_1','Shrine2_2','Shrine2_3','Shrine2_4','Shrine2_5','Shrine2_6'} do
            MakeHeroInteractWithObject("GhostFSLord2", shrine)
        end
    end)
    sleep(20)
    consoleCmd("setvar ui_announcement_duration = 3500")
end)
-- стартовое сообщение
-- MapLoadingEvent.AddListener('BTD_duel_start_message_listener',
-- function()
--     for player = PLAYER_1, PLAYER_2 do
--         startThread(MCCS_MessageBoxForPlayers, player, GetMapDataPath().."Messages/start.txt")
--         startThread(SkipTurnMessage, player)
--     end
-- end)
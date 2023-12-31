pick_ban_stage = {
    path = "/scripts/Duel/advmap/DaySequence/PickBanStage/",
    hero_pool = {
        -- Пул доступных для спавна и черка героев; все герои должны быть зарезервированы
        [TOWN_HEAVEN] = {
                        'Ving', -- Айрис
                        'Sarge', -- Аксель
                        'Christian', -- Витторио
                        'Orrin', -- Дугал
                        'Mardigo', -- Ласло
                        'Maeve', -- Мив
                        'Brem', -- Рутгер
                        'Nathaniel', -- Эллайна
                        'Godric', -- Годрик
                        'Isabell', -- Изабель
                        'RedHeavenHero03', -- Валерия
                        },
        [TOWN_INFERNO] = {
                        'Efion', -- Аластор
                        'Grok', -- Грок
                        'Calid', -- Грол
                        'Oddrema', -- Джезебет
                        'Deleb', -- Дэлеб
                        'Marder', -- Марбас
                        'Jazaz', -- Ниброс
                        'Nymus', -- Нимус
                        'Biara', -- Биара
                        'Orlando', -- Орландо
                        'Agrael', -- Аграил
                        },
        [TOWN_PRESERVE] = {
                        'Metlirn', -- Анвэн
                        'Linaas', -- Вингаэль
                        'Elleshar', -- Винраэль
                        'Gillion', -- Гильраэн
                        'Diraya', -- Дираэль
                        'Itil', -- Ильфина
                        'Ossir', -- Оссир
                        'Nadaur', -- Таланар
                        'Heam', -- Файдаэн
                        'Ildar', -- Аларон
                        'Tieru', -- Тиеру
                        },
        [TOWN_NECROMANCY] = {
                        'Pelt', -- Влад
                        'Nemor', -- Дейдра
                        'Aberrar', -- Золтан
                        'Gles', -- Каспар
                        'Tamika', -- Лукреция
                        'Muscip', -- Наадир
                        'Straker', -- Орсон
                        'Effig', -- Равэнна
                        'Berein', -- Маркел
                        'Arantir', -- Арантир
                        'Ornella', -- Орнелла
                        },
        [TOWN_DUNGEON] = {
                        'Ohtarig', -- Вайшан
                        'Urunir', -- Иранна
                        'Almegir', -- Щербет
                        'Menel', --Кифра
                        'Dalom', -- Летос
                        'Inagost', -- Синитра
                        'Ferigl', -- Соргалл
                        'Eruina', -- Эрин
                        'Kelodin', -- Шадия
                        'Raelag', -- Райлаг
                        'Shadwyn', -- Илайя
                        },
        [TOWN_ACADEMY] = {
                        'Tan', -- Джалиб
                        'Nur', -- Назир
                        'Razzak', -- Нархиз
                        'Astral', -- Нура
                        'Sufi', -- Ора
                        'Isher', -- Раззак
                        'Faiz', -- Фаиз
                        'Havez', -- Хафиз
                        'Maahir', -- Маахир
                        'Zehir', -- Зехир
                        'Cyrus', -- Сайрус
                        },
        [TOWN_FORTRESS] = {
                        'Brand', -- Бранд
                        'Bersy', -- Ибба
                        'Una', -- Инга
                        'Ingvar', -- Ингвар
                        'Skeggy', -- Карли
                        'Vegeyr', -- Свея
                        'Ottar', -- Зельмар
                        'Egil', -- Эрлинг
                        'Wulfstan', -- Вульфстен
                        'Rolf', -- Рольф
                        'KingTolghar'
                        },
        [TOWN_STRONGHOLD] = {
                        'Hero2', -- Аргат
                        'Hero3', -- гаруна
                        'Hero4', -- Гошак
                        'Hero9', -- Киган
                        'Hero1', -- Краг
                        'Hero8', -- Тилсек
                        'Hero7', -- Хаггеш
                        'Hero6', -- Шак'Карукат
                        'Gottai', -- Готай
                        'Kujin', -- Куджин
                        'Quroq', -- Курак
                        },
    },
    this_match_heroes = {},
    additional_hero_for_player = {[PLAYER_1] = "", [PLAYER_2] = ""},
    ban_round_for_hero_player = {[PLAYER_1] = 1, [PLAYER_2] = 1},
    active_banning_player = PLAYER_1,
    heroes_for_player = {[PLAYER_1] = {}, [PLAYER_2] = {}},
    gold_price_for_additional_hero = 4000,
    portrait_objects = {}, 
    portrait_fxs = {},

    player_picked_hero = {
        [PLAYER_1] = nil, [PLAYER_2] = nil
    }
}

MapLoadingEvent.AddListener("BTD_duel_pick_ban_stage",
function()
    ChangeHeroStat("GhostFSLord1", STAT_MOVE_POINTS, -10000)
    ChangeHeroStat("GhostFSLord2", STAT_MOVE_POINTS, -10000)
    Touch.DisableObject("start_game_portal_p1")
    Touch.DisableObject("start_game_portal_p2")
    SetRegionBlocked("start_game_block_p1", 1, -1)
    SetRegionBlocked("start_game_block_p2", 1, -1)
    SetRegionBlocked("ban_block_p1", 1, -1)
    SetRegionBlocked("ban_block_p2", 1, -1)
    SetupPlayer(PLAYER_1, GetPlayerRace(PLAYER_2))
    SetupPlayer(PLAYER_2, GetPlayerRace(PLAYER_1))
    sleep()
    for player = PLAYER_1, PLAYER_2 do
        local x, y, f = RegionToPoint("selected_hero_spawn_point_"..player.."2")
        SetObjectPosition("GhostFSLord"..player, x, y, f)
    end
    sleep()
    StartBanQueue()
end)

function TouchHeroPortrait(hero, object, picked_hero, player, twin_object, ban_fx, twin_fx)
    local other_player = 3 - player
    if pick_ban_stage.ban_round_for_hero_player[player] < 3 then
        if MCCS_QuestionBoxForPlayers(player, {
            pick_ban_stage.path.."wanna_ban_hero.txt"; hero_name = Hero.Params.Name(picked_hero.."1")
        }) then
            pick_ban_stage.heroes_for_player[player][picked_hero] = nil
            pick_ban_stage.ban_round_for_hero_player[player] = pick_ban_stage.ban_round_for_hero_player[player] + 1
            Object.RemoveSelection(object, twin_object)
            StopVisualEffects(ban_fx)
            StopVisualEffects(twin_fx)
            pick_ban_stage.active_banning_player = other_player
            GiveTurnToNextPlayer()
        end
    else
        if MCCS_QuestionBoxForPlayers(player, {
            pick_ban_stage.path.."wanna_make_hero_priceable.txt"; hero_name = Hero.Params.Name(picked_hero.."1")
        }) then
            pick_ban_stage.additional_hero_for_player[other_player] = picked_hero..""..other_player
            print("Additional hero for ", other_player, " is ", picked_hero..""..other_player)
            if pick_ban_stage.active_banning_player == PLAYER_1 then
                pick_ban_stage.active_banning_player = 3 - pick_ban_stage.active_banning_player
                GiveTurnToNextPlayer()
            else
                StartHeroSelection()
            end
        end
    end
end

function SetupPlayer(player, other_player_race)
    local other_player = 3 - player
    local heroes_count = 0
    while 1 do
        local picked_hero = Random.FromTable(pick_ban_stage.hero_pool[other_player_race])
        if not pick_ban_stage.this_match_heroes[picked_hero] then
            pick_ban_stage.this_match_heroes[picked_hero] = 1
            pick_ban_stage.heroes_for_player[player][picked_hero] = 1
            heroes_count = heroes_count + 1
            local ban_place = "ban_hero_place_"..player..""..heroes_count
            local player_hero_place = "player_hero_place_"..other_player..""..heroes_count
            pick_ban_stage.portrait_objects[ban_place] = 1
            pick_ban_stage.portrait_objects[player_hero_place] = 1
            local ban_fx = "ban_fx_"..player..""..heroes_count
            local player_hero_fx = "player_hero_fx"..other_player..""..heroes_count
            pick_ban_stage.portrait_fxs[ban_fx] = 1
            pick_ban_stage.portrait_fxs[player_hero_fx] = 1
            PlayVisualEffect("/PickBanStage/"..picked_hero.."/active.(Effect).xdb#xpointer(/Effect)", ban_place, ban_fx)
            PlayVisualEffect("/PickBanStage/"..picked_hero.."/active.(Effect).xdb#xpointer(/Effect)", player_hero_place, player_hero_fx)
            Touch.DisableObject(ban_place, DISABLED_INTERACT, Hero.Params.Name(picked_hero.."1"), Hero.Params.SpecDesc(picked_hero.."1"))
            Touch.DisableObject(player_hero_place, DISABLED_INTERACT, Hero.Params.Name(picked_hero.."1"), Hero.Params.SpecDesc(picked_hero.."1"))
            Touch.SetFunction(ban_place, "_try_ban_hero",
            function(hero, object)
                startThread(TouchHeroPortrait, hero, object, %picked_hero, %player, %player_hero_place, %ban_fx, %player_hero_fx)
            end)
            if heroes_count == 5 then 
                break
            end
        end
        sleep()
    end
end

function StartBanQueue()
    startThread(Hero.Threads.UnlimMove, "GhostFSLord1", function() return pick_ban_stage.active_banning_player == PLAYER_1 end)
    startThread(MCCS_MessageBoxForPlayers, PLAYER_1, pick_ban_stage.path.."your_turn_to_ban.txt")
end

function GiveTurnToNextPlayer()
    local player = pick_ban_stage.active_banning_player
    local other_player = 3 - player
    ChangeHeroStat("GhostFSLord"..other_player, STAT_MOVE_POINTS, -10000)
    if pick_ban_stage.ban_round_for_hero_player[player] < 3 then
        startThread(MCCS_MessageBoxForPlayers, player, pick_ban_stage.path.."your_turn_to_ban.txt")
    else
        startThread(MCCS_MessageBoxForPlayers, player, pick_ban_stage.path.."your_turn_to_make_priceable.txt")
    end
    startThread(Hero.Threads.UnlimMove, "GhostFSLord"..player, function() return pick_ban_stage.active_banning_player == %player end)
end

function TouchPortal(hero, object)
    local player = GetObjectOwner(hero)
    if hero == pick_ban_stage.additional_hero_for_player[player] then
        if MCCS_QuestionBoxForPlayers(player, {
            pick_ban_stage.path.."wanna_pay_a_price.txt"; amount = pick_ban_stage.gold_price_for_additional_hero
        }) then
            SetPlayerResource(player, GOLD, GetPlayerResource(player, GOLD) - pick_ban_stage.gold_price_for_additional_hero)
            startThread(SelectHero, hero, player)
        end
    else
        if MCCS_QuestionBoxForPlayers(player, pick_ban_stage.path.."wanna_select_hero.txt") then
            startThread(SelectHero, hero, player)
        end
    end
end

function StartHeroSelection()
    for i, portal in {"start_game_portal_p1", "start_game_portal_p2"} do
        Touch.SetFunction(portal, "_touch", TouchPortal)
    end
    SetRegionBlocked("start_game_block_p1", nil, -1)
    SetRegionBlocked("start_game_block_p2", nil, -1)
    Object.RemoveSelection("GhostFSLord1", "GhostFSLord2", "firewall_p1", "firewall_p2")
    for object, _ in pick_ban_stage.portrait_objects do
        if IsObjectExists(object) then
            RemoveObject(object)
        end
    end
    for fx, _ in pick_ban_stage.portrait_fxs do
        startThread(StopVisualEffects, fx)
    end
    for player = PLAYER_1, PLAYER_2 do
        startThread(SpawnNonBannedHeroes, player)
    end
end

function SpawnNonBannedHeroes(player)
    SetPlayerStartResources(player, 0, 0, 0, 0, 0, 0, btd_duel_loading.start_gold)
    local spawned_count = 1
    for hero, non_banned in pick_ban_stage.heroes_for_player[3 - player] do
        if hero and non_banned then
            scouting_duel.non_banned_heroes_for_player[player][len(scouting_duel.non_banned_heroes_for_player[player]) + 1] = hero..""..player
            local x, y, f = RegionToPoint("selected_hero_spawn_point_"..player..""..spawned_count)
            DeployReserveHero(hero..""..player, x, y, f)
            spawned_count = spawned_count + 1
            if spawned_count == 4 then
                return
            end
        end
    end
end

function SelectHero(hero, player)
    for i, _hero in GetPlayerHeroes(player) do
        if _hero ~= hero then
            RemoveObject(_hero)
        end
    end
    Touch.RemoveFunctions("start_game_portal_p"..player)
    SetObjectEnabled("start_game_portal_p"..player, 1)
    --ChangeHeroStat(hero, STAT_MOVE_POINTS, -10000)
    sleep()
    MakeHeroInteractWithObject(hero, "start_game_portal_p"..player)
    pick_ban_stage.player_picked_hero[player] = 1
    btd_duel_free_roam.free_roam_active_for_hero[hero] = 1
    startThread(Hero.Threads.UnlimMove, hero, function() return btd_duel_free_roam.free_roam_active_for_hero[%hero] end)
    sleep(10)
    Calibrate(hero)
    startThread(MCCS_MessageBoxForPlayers, player, "/scripts/Duel/advmap/DaySequence/skip_day_when_ready.txt")
end

MapLoadingEvent.AddListener("BTD_duel_pick_ban_stage_waiting",
function()
    while 1 do
        if pick_ban_stage.player_picked_hero[PLAYER_1] and pick_ban_stage.player_picked_hero[PLAYER_2] then
            startThread(BTD_Duel_DaySequenceInit)
            return
        end
        sleep()
    end
end)
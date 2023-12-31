----------------------------------------
-- Третий день - выдача опыта и армии --

BTD_Duel_ArmyDistribution =
{
    [TOWN_INFERNO] = {random(13) + 206, random(21) + 198, random(12) + 86, random(9) + 45, random(7) + 26, random(2) + 14, random(1) + 6}, -- инферно
    [TOWN_PRESERVE] = {random(18) + 135, random(13)+105, random(10)+74, random(6)+33, random(6)+22, random(4)+15, random(1)+6}, -- эльфы
    [TOWN_ACADEMY] = {random(18) + 278, random(24) + 188, random(23) + 109, random(7) + 40, random(10) + 27, random(3) + 14, random(1) + 6}, -- маги
    [TOWN_DUNGEON] = {random(12)+ 108, random(12) + 84, random(11) + 69, random(8)+33, random(7)+22, random(3)+14, random(1)+6}, -- ТЭ
    [TOWN_NECROMANCY] = {random(22)+271, random(13)+164, random(12)+80, random(9)+41, random(8)+21, random(3)+ 14, random(1) + 9}, -- некры
    [TOWN_HEAVEN] = {random(21)+300, random(16)+136, random(9)+100, random(12)+42, random(6)+21, random(2)+14, random(1)+6}, -- люди
    [TOWN_FORTRESS] = {random(22)+210, random(15)+160, random(12)+70, random(16)+71, random(7)+22, random(2)+13, random(1)+6}, -- гномы
    [TOWN_STRONGHOLD] = {random(29)+331, random(22)+135, random(15)+107, random(7)+41, random(6)+37, random(3)+14, random(1)+6}, -- орки
    
    --
    default_func =
    function(hero, race, tier)
        local creature = TIER_TABLES[race][tier][1] 
        startThread(Hero.CreatureInfo.Add, hero, creature, BTD_Duel_ArmyDistribution[race][tier])
    end,

    --
    custom_add_func =
    {}
}

AddHeroEvent.AddListener("btd_duel_custom_add_func_add_hero",
function(hero)
    BTD_Duel_ArmyDistribution.custom_add_func[hero] = {}
end)

NewDayEvent.AddListener('btd_duel_add_army_listener',
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for player = PLAYER_1, PLAYER_2 do
            startThread(
            function()
                local hero = GetPlayerHeroes(%player)[0]
                local race = Hero.Params.Town(hero)
                --
                if not BTD_Duel_ArmyDistribution.custom_add_func[hero][1] then
                    startThread(BTD_Duel_ArmyDistribution.default_func, hero, race, 1)
                else
                    startThread(BTD_Duel_ArmyDistribution.custom_add_func[hero][1], hero)
                end
                --
                while Hero.CreatureInfo.StackCount(hero) == 1 do
                    sleep()
                end
                --
                RemoveHeroCreatures(hero, CREATURE_AIR_ELEMENTAL, 9999)
                while GetHeroCreatures(hero, CREATURE_AIR_ELEMENTAL) > 0 do
                    sleep()
                end
                --
                for tier = 2, 7 do 
                    if not BTD_Duel_ArmyDistribution.custom_add_func[hero][tier] then
                        startThread(BTD_Duel_ArmyDistribution.default_func, hero, race, tier)
                    else
                        startThread(BTD_Duel_ArmyDistribution.custom_add_func[hero][tier], hero)
                    end
                end
            end)
        end
    end
end)

btd_duel_level_up = {
    base_level = 9,
    max_level = 18,
    lvl_up_stones = {"obelisklvlup1", "obelisklvlup2"}
}

-- в начале дня повысить лвл до 9.
NewDayEvent.AddListener("BTD_duel_lvl_base_new_day",
function(day)
    if day == BTD_duel_day_sequence.level_army_day then
        for player = PLAYER_1, PLAYER_2 do
            local hero = GetPlayerHeroes(player)[0]
            GiveExp(hero, Levels[btd_duel_level_up.base_level])
            startThread(MCCS_MessageBoxForPlayers, player, "/scripts/Duel/advmap/DaySequence/skip_day_when_ready.txt")
        end
    end
end)

-- камень повышает до 18.
NewDayEvent.AddListener("BTD_duel_learing_stones_init",
function()
    for _, object in btd_duel_level_up.lvl_up_stones do
        Touch.DisableObject(
            object, 
            DISABLED_INTERACT,
            "/scripts/Duel/advmap/DaySequence/Level&Army/learning_stone_name.txt",
            "/scripts/Duel/advmap/DaySequence/Level&Army/learning_stone_desc.txt"
        )
        Touch.SetFunction(object, "_touch_lvlupstone",
        function(hero, object)
            local curr_level = GetHeroLevel(hero)
            if curr_level < btd_duel_level_up.base_level then
                startThread(MCCS_MessageBoxForPlayers, GetObjectOwner(hero), "/scripts/Duel/advmap/DaySequence/Level&Army/not_enough_exp.txt")
                return
            end
            Touch.RemoveFunctions(object)
            startThread(GiveExp, hero, Levels[btd_duel_level_up.max_level] - Levels[curr_level])
            Touch.DisableObject(object, DISABLED_BLOCKED)
        end) 
    end
end)

-- Настройка порталов с артами.

btd_art_portals = {
    _entrance_suffix = "_entrance",
    _player_prefixes = { "p1_", "p2_"},
    _portal_pairs = { ["left"] = "right", ["right"] = "left" }
}

MapLoadingEvent.AddListener("BTD_duel_art_portals_init",
function ()
    for _, p in btd_art_portals._player_prefixes do
        for touch, block in btd_art_portals._portal_pairs do
            local touched_portal = p..touch..btd_art_portals._entrance_suffix
            local blocked_portal = p..block..btd_art_portals._entrance_suffix
            Touch.SetFunction(touched_portal, "_touch_"..touched_portal,
            function(hero, object)
                local bp = %blocked_portal
                Touch.DisableObject(bp, DISABLED_BLOCKED)
                Touch.RemoveFunctions(bp)
                Touch.RemoveFunctions(object)
            end)
        end
    end
end)

-- NewDayEvent.AddListener("BTD_duel_unlim_move_setup_listener",
-- function(day)
--     if day == BTD_duel_day_sequence.level_army_day then
--         for i, hero in GetObjectNamesByType("HERO") do
--             startThread(Hero.Threads.UnlimMove, hero, function() return btd_duel_free_roam.free_roam_active_for_hero[%hero] end)
--         end
--     end
-- end)
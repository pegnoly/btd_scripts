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
    function(hero)
        local race = Hero.Params.Town(hero)
        for tier = 1, 7 do
            local creature = TIER_TABLES[race][tier][1] 
            startThread(Hero.CreatureInfo.Add, hero, creature, BTD_Duel_ArmyDistribution[race][tier])
        end
    end,

    --
    custom_add_func =
    {}
}

NewDayEvent.AddListener('BTD_duel_add_army_listener',
function(day)
    if day == BTD_LEVEL_ARMY_DAY then
        for player = PLAYER_1, PLAYER_2 do
            startThread(
            function()
                local hero = GetPlayerHeroes(%player)[0]
                if not BTD_Duel_ArmyDistribution.custom_add_func[hero] then
                    startThread(BTD_Duel_ArmyDistribution.default_func, hero)
                else
                    startThread(BTD_Duel_ArmyDistribution.custom_add_func[hero], hero)
                end
            end)
        end
    end
end)

--#region

NewDayEvent.AddListener('BTD_duel_level_up_listener',
function(day)
    if day == BTD_LEVEL_ARMY_DAY then
        for player = PLAYER_1, PLAYER_2 do
            local hero = GetPlayerHeroes(player)[0]
            local level = Random.FromSelection(19, 19) -- :)
            startThread(MCCS_MessageBoxForPlayers, player, {GetMapDataPath().."Messages/got_lvl.txt"; lvl = level})
            startThread(GiveExp, hero, Levels[level])
            --startThread(SkipTurnMessage, player)
        end
    end
end)
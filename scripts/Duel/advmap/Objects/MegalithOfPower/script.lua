megalith_of_power = {
    path = "/scripts/Duel/advmap/Objects/MegalithOfPower/",
    creature_cost = 3000,
    stat_cost = 4000,
    stat_amount = 2,
    lvl6_amount = 2,
    lvl7_amount = 1,
    used_by_player = {}
}

MapLoadingEvent.AddListener("btd_megalith_of_power_init_listener",
function()
    for _, megalith in {"megalith_p1", "megalith_p2"} do
        Touch.DisableObject(megalith)
        Touch.SetFunction(megalith, "_touch_megalith_of_power", MegalithOfPower_Touch)
    end
end)

function MegalithOfPower_Touch(hero, object)
    local player = GetObjectOwner(hero)
    if not megalith_of_power.used_by_player[player] then
        if MCCS_QuestionBoxForPlayers(player, megalith_of_power.path.."select_bonus_type.txt") then
            startThread(MegalithOfPower_SelectStats, hero, player)
        else
            startThread(MegalithOfPower_SelectCreatures, hero, player)
        end
    else
        startThread(MCCS_MessageBoxForPlayers, player, megalith_of_power.path.."already_used.txt")
    end
end

function MegalithOfPower_Confirm(hero, player, cost, callback)
    local actual_cost = economy.GetCostWithEconomy(hero, cost) 
    if MCCS_QuestionBoxForPlayers(player, {megalith_of_power.path.."confirm.txt"; cost = actual_cost}) then
        local gold = GetPlayerResource(player, GOLD)
        if gold >= actual_cost then
            megalith_of_power.used_by_player[player] = 1
            local economed_gold = cost - actual_cost
            economy.EconomGold(hero, economed_gold)
            SetPlayerResource(player, GOLD, GetPlayerResource(player, GOLD) - actual_cost)
            startThread(callback)
        else
            startThread(MCCS_MessageBoxForPlayers, player, megalith_of_power.path.."not_enough_gold.txt")
        end
    else
        return nil
    end
end

function MegalithOfPower_SelectStats(hero, player)
    if MCCS_QuestionBoxForPlayers(player, megalith_of_power.path.."select_stat_type.txt") then
        startThread(MegalithOfPower_SelectMightStat, hero, player)
    else
        startThread(MegalithOfPower_SelectMagicStat, hero, player)    
    end
end

function MegalithOfPower_SelectMightStat(hero, player)
    if MCCS_QuestionBoxForPlayers(player, {
        megalith_of_power.path.."select_stat.txt"; 
        amount = megalith_of_power.stat_amount, 
        stat_name = megalith_of_power.path.."attack.txt",
        amount2 = megalith_of_power.stat_amount, 
        stat_name2 = megalith_of_power.path.."defence.txt"
    }) then
        local callback = function()
            Hero.Stats.Change(%hero, STAT_ATTACK, megalith_of_power.stat_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.stat_cost, callback)
    else 
        local callback = function()
            Hero.Stats.Change(%hero, STAT_DEFENCE, megalith_of_power.stat_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.stat_cost, callback)
    end
end

function MegalithOfPower_SelectMagicStat(hero, player)
  if MCCS_QuestionBoxForPlayers(player, {
      megalith_of_power.path.."select_stat.txt"; 
      amount = megalith_of_power.stat_amount, 
      stat_name = megalith_of_power.path.."spellpower.txt",
      amount2 = megalith_of_power.stat_amount, 
      stat_name2 = megalith_of_power.path.."knowledge.txt"
  }) then
        local callback = function()
            Hero.Stats.Change(%hero, STAT_SPELL_POWER, megalith_of_power.stat_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.stat_cost, callback)
    else        
        local callback = function()
            Hero.Stats.Change(%hero, STAT_KNOWLEDGE, megalith_of_power.stat_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.stat_cost, callback)
    end
end

function MegalithOfPower_SelectCreatures(hero, player)
    if MCCS_QuestionBoxForPlayers(player, {megalith_of_power.path.."select_creatures.txt"; 
        lvl6_amount = megalith_of_power.lvl6_amount,
        lvl7_amount = megalith_of_power.lvl7_amount
    }) then
        local callback = function ()
            local town = Hero.Params.Town(%hero)
            Hero.CreatureInfo.DefaultGrow(%hero, town, 6, megalith_of_power.lvl6_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.creature_cost, callback)
    else
        local callback = function ()
            local town = Hero.Params.Town(%hero)
            Hero.CreatureInfo.DefaultGrow(%hero, town, 7, megalith_of_power.lvl7_amount)
        end
        startThread(MegalithOfPower_Confirm, hero, player, megalith_of_power.creature_cost, callback)
    end
end
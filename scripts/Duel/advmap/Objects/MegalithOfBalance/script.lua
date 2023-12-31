megalith_of_balance = {
    path = "/scripts/Duel/advmap/Objects/MegalithOfBalance/",

    common_stats = {
        [HERO_CLASS_KNIGHT] = {STAT_DEFENCE, STAT_ATTACK},
        [HERO_CLASS_RANGER] = {STAT_DEFENCE, STAT_KNOWLEDGE},
        [HERO_CLASS_WIZARD] = {STAT_SPELL_POWER, STAT_KNOWLEDGE},
        [HERO_CLASS_DEMON_LORD] = {STAT_ATTACK, STAT_KNOWLEDGE},
        [HERO_CLASS_NECROMANCER] = {STAT_DEFENCE, STAT_SPELL_POWER},
        [HERO_CLASS_WARLOCK] = {STAT_ATTACK, STAT_SPELL_POWER},
        [HERO_CLASS_RUNEMAGE] = {STAT_DEFENCE, STAT_KNOWLEDGE},
        [HERO_CLASS_BARBARIAN] = {STAT_DEFENCE, STAT_ATTACK},
    },

    rare_stats = {
        [HERO_CLASS_KNIGHT] = {STAT_SPELL_POWER, STAT_KNOWLEDGE},
        [HERO_CLASS_RANGER] = {STAT_SPELL_POWER, STAT_ATTACK},
        [HERO_CLASS_WIZARD] = {STAT_ATTACK, STAT_DEFENCE},
        [HERO_CLASS_DEMON_LORD] = {STAT_DEFENCE, STAT_SPELL_POWER},
        [HERO_CLASS_NECROMANCER] = {STAT_ATTACK, STAT_KNOWLEDGE},
        [HERO_CLASS_WARLOCK] = {STAT_DEFENCE, STAT_KNOWLEDGE},
        [HERO_CLASS_RUNEMAGE] = {STAT_ATTACK, STAT_SPELL_POWER},
        [HERO_CLASS_BARBARIAN] = {STAT_SPELL_POWER, STAT_KNOWLEDGE},
    },
       
    cost = 1500,
    used_by_player = {[PLAYER_1] = 0, [PLAYER_2] = 0},
    times_avaliable = 2
}

function MegalithOfBalance_Touch(hero, object)
    local player = GetObjectOwner(hero)
    if megalith_of_balance.used_by_player[player] == megalith_of_balance.times_avaliable then
        startThread(MCCS_MessageBoxForPlayers, player, megalith_of_balance.path.."already_used.txt")
        return
    end
    local class = Hero.Params.Class(hero)
    for i, stat in megalith_of_balance.rare_stats[class] do
        if GetHeroStat(hero, stat) < 1 then
            startThread(MCCS_MessageBoxForPlayers, player, megalith_of_balance.path.."cant_use.txt")
            return
        end
    end
    --
    local actual_cost = economy.GetCostWithEconomy(hero, megalith_of_balance.cost)
    if MCCS_QuestionBoxForPlayers(player, {
        megalith_of_balance.path.."dialog.txt";
        rare1 = StatNames[megalith_of_balance.rare_stats[class][1]],
        rare2 = StatNames[megalith_of_balance.rare_stats[class][2]],
        common1 = StatNames[megalith_of_balance.common_stats[class][1]],
        common2 = StatNames[megalith_of_balance.common_stats[class][2]],
        cost = actual_cost
    }) then
        local gold = GetPlayerResource(player, GOLD)
        if gold < actual_cost then
            startThread(MCCS_MessageBoxForPlayers, player, megalith_of_balance.path.."not_enough_gold.txt")
            return
        end
        economy.EconomGold(hero, megalith_of_balance.cost - actual_cost)
        SetPlayerResource(player, GOLD, GetPlayerResource(player, GOLD) - actual_cost)
        megalith_of_balance.used_by_player[player] = megalith_of_balance.used_by_player[player] + 1
        Hero.Stats.Change(hero, megalith_of_balance.rare_stats[class][1], -1)
        Hero.Stats.Change(hero, megalith_of_balance.rare_stats[class][2], -1)
        Hero.Stats.Change(hero, megalith_of_balance.common_stats[class][1], 1)
        Hero.Stats.Change(hero, megalith_of_balance.common_stats[class][2], 1)
    end
end

MapLoadingEvent.AddListener("btd_duel_megalith_of_balance_init",
function ()
    for i, object in {"megalith_of_balance_p1", "megalith_of_balance_p2"} do
        Touch.DisableObject(object)
        Touch.SetFunction(object, "_touch_megalith_of_balance", MegalithOfBalance_Touch)
    end
end)
spell_shop = {
    path = "/scripts/Duel/advmap/Objects/SpellShop/",
    cost_by_level = {[3] = 2000, [4] = 4250, [5] = 7000},
    used_by_player = {},
    return_position_for_player = {}
}

MapLoadingEvent.AddListener("btd_duel_spell_shop_init",
function()
    for spell_lvl = 3, 5 do
        for player = PLAYER_1, PLAYER_2 do
            Touch.DisableObject(
                "spell_shop_"..player..""..spell_lvl, 
                nil,
                spell_shop.path.."lvl"..spell_lvl.."_name.txt",
                spell_shop.path.."lvl"..spell_lvl.."_desc.txt"
            )
            Touch.SetFunction("spell_shop_"..player..""..spell_lvl, "_spell_shop_touch",
            function(hero, object)
                startThread(SpellShop_TryToBuySpell, hero, %player, %spell_lvl)            
            end)
        end
    end
    -- 
    for _, shop in {"spell_shop_p1", "spell_shop_p2"} do
        Touch.DisableObject(shop)
        Touch.SetFunction(shop, "_spell_shop_touch",
        function(hero, object)
            local player = GetObjectOwner(hero)
            if spell_shop.used_by_player[player] then
                startThread(MCCS_MessageBoxForPlayers, player, spell_shop.path.."already_used.txt")
                return
            end
            local px, py, pf = GetObjectPosition(hero)
            spell_shop.return_position_for_player[player] = {x = px, y = py, f = pf}
            local x, y, f = RegionToPoint("spell_shop_enter_p"..player)
            SetObjectPosition(hero, x, y, f)
        end)
    end
    --
    for _, portal in {"spell_shop_out_p1", "spell_shop_out_p2"} do
        Touch.DisableObject(portal, DISABLED_INTERACT)
        Touch.SetFunction(portal, "_out_spell_shop",
        function(hero, object)
            local return_pos = spell_shop.return_position_for_player[GetObjectOwner(hero)]
            SetObjectPosition(hero, return_pos.x, return_pos.y, return_pos.f)
        end)
    end
end)

function SpellShop_TryToBuySpell(hero, player, spell_lvl)
    if spell_shop.used_by_player[player] then
        startThread(MCCS_MessageBoxForPlayers, player, spell_shop.path.."already_used.txt")
        return
    end
    local spells = Hero.SpellInfo.GetLearnableSpellsByLevel(hero, spell_lvl)
    if not spells then
        startThread(MCCS_MessageBoxForPlayers, player, spell_shop.path.."nothing_to_learn.txt")
        return
    end
    local actual_cost = economy.GetCostWithEconomy(hero, spell_shop.cost_by_level[spell_lvl])
    local economed_gold = spell_shop.cost_by_level[spell_lvl] - actual_cost
    if MCCS_QuestionBoxForPlayers(player, {
        spell_shop.path.."wanna_buy_spell.txt"; level = spell_lvl, cost = actual_cost
    }) then
        local gold = GetPlayerResource(player, GOLD)
        if gold < actual_cost then
            return
        end
        economy.EconomGold(hero, economed_gold)
        spell_shop.used_by_player[player] = 1
        SetPlayerResource(player, GOLD, gold - actual_cost)
        Hero.SpellInfo.TeachSpell(hero, Random.FromTable(spells))
        sleep()
        local return_pos = spell_shop.return_position_for_player[player]
        SetObjectPosition(hero, return_pos.x, return_pos.y, return_pos.f)
    end
end
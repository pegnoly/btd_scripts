-- мегалит опыта
lvl_megalith =
{
  cost = {[0] = 2500, [1] = 5000, [2] = 7500, [3] = 10000}, -- цена за 1, 2 и 3 использование мегалита

  used_by_player = {[PLAYER_1] = 0, [PLAYER_2] = 0},

  Init =
  function()
    for i, megalith in {"megalith_lvl_p1", "megalith_lvl_p2"} do
      Touch.DisableObject(megalith)
      Touch.SetFunction(megalith, "_touch_megalith",
      function(hero, object)
        local player = GetObjectOwner(hero)
        local times_used = lvl_megalith.used_by_player[player]
        if times_used == 4 then
          startThread(MCCS_MessageBoxForPlayers, player, MEGALITH_OF_POWER_PATH.."already_used.txt")
        else
          -- 22.08. Конфигурация цен после реворка логистики
          local cost = economy.GetCostWithEconomy(hero, lvl_megalith.cost[times_used])
          local economed_gold = lvl_megalith.cost[times_used] - cost
          --
          if MCCS_QuestionBoxForPlayers(player, {MEGALITH_OF_POWER_PATH.."exp.txt"; cost = cost}) then
            local gold = GetPlayerResource(player, GOLD)
            if gold > cost then
              SetPlayerResource(player, GOLD, gold - cost)
              -- 22.08. Экономия золота после реворка логистики
              economy.EconomGold(hero, economed_gold)
              --
              LevelUpHero(hero)
              lvl_megalith.used_by_player[player] = lvl_megalith.used_by_player[player] + 1
            else
              startThread(MCCS_MessageBoxForPlayers, player, MEGALITH_OF_POWER_PATH.."not_enough_gold.txt")
            end
          end
        end
      end)
    end
  end,
}

MapLoadingEvent.AddListener("btd_lvl_megalith_init_event",
function()
  startThread(lvl_megalith.Init)
end)
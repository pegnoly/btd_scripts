-- Мегалит силы
MEGALITH_OF_POWER_PATH = GetMapDataPath().."Megalith/"
MEGALITH_STAT_BONUS = 2 -- число статов, которые дает мегалит
MEGALITH_LVL_6_BONUS = 2 -- число существ 6 уровня, которые дает мегалит
MEGALITH_LVL_7_BONUS = 1 -- число существ 7 уровня, которые дает мегалит

megalith_of_power_dialog =
{
  path = MEGALITH_OF_POWER_PATH,
  state = 1,
  icon = "/UI/H5A1/Icons/Abilites/Heroes_Abillites/128x128/Snatch.(Texture).xdb#xpointer(/Texture)",
  title = "title",
  select_text = "",
  perform_func =
  function(player, curr_state, answer, next_state)
    local return_state = 0
    local hero = Dialog.GetActiveHeroForPlayer(player)
    local race = Hero.Params.Town(hero)
    local gold = GetPlayerResource(player, GOLD)
    -- 22.08. Конфигурация цен после реворка логистики
    local actual_cost = economy.GetCostWithEconomy(hero, megalith.cost_of_gold)
    local economed_gold = megalith.cost_of_gold - actual_cost
    --
    if next_state == 0 then
      return 0
    end
    --
    if curr_state == 1 then
      if next_state ~= 2 then
        --
        if gold < actual_cost then
          startThread(MCCS_MessageBoxForPlayers, player, MEGALITH_OF_POWER_PATH.."not_enough_gold.txt")
          return 0
        end
        --
        SetPlayerResource(player, GOLD, gold - actual_cost)
        -- 22.08. Экономия золота после реворка логистики
        economy.EconomGold(hero, economed_gold)
        --
        megalith.used_by_player[player] = 1
        if next_state == 101 then
          startThread(Hero.Stats.Change, Dialog.GetActiveHeroForPlayer(player), STAT_ATTACK, MEGALITH_STAT_BONUS)
        elseif next_state == 102 then
          startThread(Hero.Stats.Change, Dialog.GetActiveHeroForPlayer(player), STAT_DEFENCE, MEGALITH_STAT_BONUS)
        elseif next_state == 103 then
          startThread(Hero.Stats.Change, Dialog.GetActiveHeroForPlayer(player), STAT_SPELL_POWER, MEGALITH_STAT_BONUS)
        elseif next_state == 104 then
          startThread(Hero.Stats.Change, Dialog.GetActiveHeroForPlayer(player), STAT_KNOWLEDGE, MEGALITH_STAT_BONUS)
        end
      else
        return_state = 2
      end
    else
      if next_state ~= 1 then
        --
        if gold < actual_cost then
          startThread(MCCS_MessageBoxForPlayers, player, MEGALITH_OF_POWER_PATH.."not_enough_gold.txt")
          return 0
        end
        --
        SetPlayerResource(player, GOLD, gold - actual_cost)
        -- 22.08. Экономия золота после реворка логистики
        economy.EconomGold(hero, economed_gold)
        --
        megalith.used_by_player[player] = 1
        if next_state == 101 then
          startThread(Hero.CreatureInfo.DefaultGrow, hero, race, 6, MEGALITH_LVL_6_BONUS)
        elseif next_state == 102 then
          startThread(Hero.CreatureInfo.DefaultGrow, hero, race, 7, MEGALITH_LVL_7_BONUS)
        end
      else
        return_state = 1
      end
    end
    return return_state
  end,

  options =
  {
   [1] =
   {
     [0] = "info.txt",
     [1] = {"attack.txt", 101, 1},
     [2] = {"defence.txt", 102, 1},
     [3] = {"sp.txt", 103, 1},
     [4] = {"knowledge.txt", 104, 1},
     [5] = {"next.txt", 2, 1}
   },
   [2] =
   {
     [0] = "info.txt",
     [1] = {"tier6.txt", 101, 1},
     [2] = {"tier7.txt", 102, 1},
     [3] = {"back.txt", 1, 1}
   },
  },

  Open =
  function(player)
    local hero = Dialog.GetActiveHeroForPlayer(player)
    local actual_cost = economy.GetCostWithEconomy(hero, megalith.cost_of_gold)
    print("Megalith: cost is ", actual_cost)
    Dialog.GetActiveDialogForPlayer(player).options[1][0] = {MEGALITH_OF_POWER_PATH.."info.txt"; cost = actual_cost}
    Dialog.GetActiveDialogForPlayer(player).options[2][0] = {MEGALITH_OF_POWER_PATH.."info.txt"; cost = actual_cost}
    Dialog.Action(player)
  end
}

megalith =
{
  cost_of_gold = 3500, -- цена использования мегалита

  used_by_player = {[PLAYER_1] = nil, [PLAYER_2] = nil},

  Init =
  function()
    for i, object in {"megalith_p1", "megalith_p2"} do
      SetObjectEnabled(object, nil)
      Trigger(OBJECT_TOUCH_TRIGGER, object, "megalith.Touch")
    end
  end,

  Touch =
  function(hero, object)
    local player = GetObjectOwner(hero)
    if not megalith.used_by_player[player] then
      startThread(Dialog.NewDialog, megalith_of_power_dialog, hero, player)
    else
      startThread(MCCS_MessageBoxForPlayers, player, MEGALITH_OF_POWER_PATH.."already_used.txt")
    end
  end
}

MapLoadingEvent.AddListener("btd_megalith_init_event",
function()
  startThread(megalith.Init)
end)